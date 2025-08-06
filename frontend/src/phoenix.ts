import { Socket } from 'phoenix';

const socket = new Socket('ws://localhost:4000/socket', {
    logger: (kind, msg, data) => {
        console.log(`${kind}: ${msg}`, data);
    },
});
socket.connect();

export const telemetryChannel = socket.channel('telemetry:metrics', {});
telemetryChannel
    .join()
    .receive('ok', (res) => {
        console.log('Joined telemetry channel successfully', res);
    })
    .receive('error', (res) => {
        console.log('Unable to join telemetry channel', res);
    });

export const cryptoChannel = socket.channel('crypto:prices', {});
cryptoChannel
    .join()
    .receive('ok', (res) => {
        console.log('Joined crypto channel successfully', res);
    })
    .receive('error', (res) => {
        console.log('Unable to join crypto channel', res);
    });
