# gunicorn-asgi-k8s-bench

Benchmarking scaling via k8s replicas compared to Gunicorn workers

Install:

- kubectl
- minikube

Run `make cluster-up` to bring up a minikube cluster with 8 vCPUs and 4GiB of memory.
Make sure you have 8 or more CPUs and enough memory available in the virtualization layer (how to configure depends on your OS, how minikube is running, etc.).
Note that **this will delete any existing minikube clusters**.

Now run `make run-in-cluser`.
Minikube will print out the URL for the service (something like `http://127.0.0.1:49434`).
Use this URL to run `wrk` against the service, for example using `wrk -c 64 -t 16 -d 10 http://127.0.0.1:49434`.
Then tweak the manifest and run again.

## Example results

### 1000m CPU, 200Mi memory, 6 replicas, 1 worker

```shell
Running 10s test @ http://127.0.0.1:49735
  16 threads and 64 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   551.36ms  208.79ms   1.28s    71.35%
    Req/Sec     8.78      5.29    30.00     71.93%
  1135 requests in 10.02s, 129.68KB read
Requests/sec:    113.29
Transfer/sec:     12.94KB
```

### 500m CPU, 100Mi memory, 12 replicas, 1 worker

```shell
Running 10s test @ http://127.0.0.1:50479
  16 threads and 64 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   355.87ms   76.24ms 799.50ms   87.69%
    Req/Sec    12.20      5.87    30.00     60.89%
  1766 requests in 10.10s, 201.78KB read
Requests/sec:    174.78
Transfer/sec:     19.97KB
```

### 6000m CPU, 1200Mi memory, 1 replica, 6 workers

```shell
Running 10s test @ http://127.0.0.1:49962
  16 threads and 64 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   644.10ms  401.94ms   1.40s    75.79%
    Req/Sec     7.27      6.59    30.00     85.23%
  740 requests in 10.02s, 84.55KB read
  Socket errors: connect 0, read 0, write 0, timeout 75
Requests/sec:     73.88
Transfer/sec:      8.44KB
```

### 6000m CPU, 1200Mi memory, 1 replica, 13 workers

```shell
Running 10s test @ http://127.0.0.1:50151
  16 threads and 64 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   803.85ms  396.40ms   1.46s    69.33%
    Req/Sec     5.86      4.67    30.00     84.97%
  626 requests in 10.02s, 71.53KB read
  Socket errors: connect 0, read 0, write 0, timeout 75
Requests/sec:     62.48
Transfer/sec:      7.14KB
```
