from pythonosc.osc_server import AsyncIOOSCUDPServer
from pythonosc.dispatcher import Dispatcher
from pythonosc import udp_client
import asyncio

client = udp_client.SimpleUDPClient("127.0.0.1", 7771) # PORT NR borde kanske inte hårdkodas?

def filter_handler(address, *args):
    print (f"{address}: {args}")

dispatcher = Dispatcher()
dispatcher.map("/filter", filter_handler)

ip = "127.0.0.1"
port = 7772

async def loop():
    for i in range(10):
        client.send_message("/filter", "from python")
        await asyncio.sleep(1)

async def init_main():
    server = AsyncIOOSCUDPServer((ip, port), dispatcher, asyncio.get_event_loop())
    transport, protocol = await server.create_serve_endpoint()

    await loop()

    transport.close()

    await loop()

asyncio.run(init_main())
