import { useState, useEffect } from 'react';
import { channel } from './phoenix';

export const useChannel = (eventName: string) => {
    const [events, setEvents] = useState<any[]>([]);

    useEffect(() => {
        channel.on(eventName, (payload) => {
            setEvents((currentEvents) =>
                [payload, ...currentEvents].slice(0, 50)
            );
        });

        channel.off(eventName);
    }, [eventName]);
    return events;
};
