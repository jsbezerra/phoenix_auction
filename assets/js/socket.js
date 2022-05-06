import {Socket} from "phoenix";

let socket = new Socket("/socket", {params: {token: "jonas"}});
socket.connect();

let match = document.location.pathname.match(/\/items\/(\d+)$/)

if (match) {
    let itemId = match[1];
    let channel = socket.channel(`item:${itemId}`, {});
    channel
        .join()
        .receive("ok", resp => {
            console.log("Joined successfully", resp);
        })
        .receive("error", resp => {
            console.log("Unable to join", resp);
        })
}

export default socket;