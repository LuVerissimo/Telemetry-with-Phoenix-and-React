import { Socket } from 'phoenix';

const socket = new Socket("ws://localhost:4000/socket", {
     logger: (kind, msg, data) => {
         console.log(`${kind}: ${msg}`, data);
     }
})
socket.connect();

export const channel = socket.channel("telemetry:metrics", {});

channel.join()
  .receive("ok", res => { console.log("Joined successfully", res) })
  .receive("error", res => { console.log("Unable to join", res) })
  .receive("timeout", () => { console.log("Connection timed out") });