.PHONY: run-app init cluster-up deploy cluster-down

build-image:
	docker build -t adriangb/k8s-gunicorn-test:latest .
	docker push adriangb/k8s-gunicorn-test:latest

run-in-docker:
	@echo "Starting app"
	docker pull adriangb/k8s-gunicorn-test:latest
	docker run -it -p 80:80 adriangb/k8s-gunicorn-test:latest

.cluster-up:
	minikube stop || true
	minikube delete || true
	minikube start --memory 3968 --cpus 8
	touch .cluster-up

cluster-up: .cluster-up

cluster-down:
	minikube stop || true
	minikube delete || true
	@rm -rf .cluster-up

run-in-cluster: .cluster-up
	kubectl delete all --all
	kubectl apply -f manifest.yaml
	minikube service service-example --url
