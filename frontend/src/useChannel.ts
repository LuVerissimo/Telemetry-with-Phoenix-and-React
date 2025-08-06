import { useState, useEffect } from 'react';
import { telemetryChannel } from './phoenix';

export const useChannel = (eventName: string) => {
    const [events, setEvents] = useState<any[]>([]);

    useEffect(() => {
        telemetryChannel.on(eventName, (payload: any) => {
            setEvents((currentEvents) =>
                [payload, ...currentEvents].slice(0, 50)
            );
        });
        return () => {
            telemetryChannel.off(eventName);
        };
    }, [eventName]);

    return events;
};
