import time
import asyncio

from asgiref.typing import Scope, ASGISendCallable, ASGIReceiveCallable


async def app(scope: Scope, receive: ASGIReceiveCallable, send: ASGISendCallable):
    # simulate a rather slow endpoint that does some sync and async work
    print("got request")
    if scope["type"] != "http":
        return
    time.sleep(0.05)
    await asyncio.sleep(0.25)
    await send(
        {
            "type": "http.response.start",
            "status": 200,
            "headers": [],
        }
    )
    await send({"type": "http.response.body", "body": b"Hello!", "more_body": False})
    print("sent response")


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app)
