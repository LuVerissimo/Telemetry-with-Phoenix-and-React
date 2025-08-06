import { useState, useEffect } from 'react';
import { cryptoChannel } from './phoenix';

export const useCryptoChannel = (eventName: string) => {
    const [data, setData] = useState<any>({});

    useEffect(() => {
        cryptoChannel.on(eventName, (payload) => {
            setData(payload);
        });
        return () => {
            cryptoChannel.off(eventName);
        };
    }, [eventName]);

    return data;
};
