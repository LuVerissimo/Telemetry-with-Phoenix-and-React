import React from 'react';
import { useChannel } from './useChannel';

interface TelemetryEvent {
    measurements: {
        duration: number;
    };
    metadata: {
        conn: {
            request_path: string;
            method: string;
        };
        route: string;
    };
}

function App() {
    const events: TelemetryEvent[] = useChannel('telemetry_event') || [];

    return (
        <div className="min-h-screen bg-gray-100 p-8">
            <h1 className="text-4xl font-bold mb-8 text-center text-gray-800">
                Real-time Telemetry Dashboard
            </h1>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {events.map((event, index) => (
                    <div
                        key={index}
                        className="bg-white rounded-lg shadow-lg p-6 hover:shadow-xl transition-shadow duration-300"
                    >
                        <div className="flex items-center mb-4">
                            <span className="text-sm font-semibold text-gray-500 mr-2">
                                {new Date().toLocaleTimeString()}
                            </span>
                            <span className="text-lg font-bold text-blue-600">
                                {event.metadata.conn.method}
                            </span>
                        </div>
                        <h2 className="text-xl font-semibold mb-2">
                            Path: {event.metadata.conn.request_path}
                        </h2>
                        <p className="text-gray-700 mb-2">
                            Route: {event.metadata.route}
                        </p>
                        <div className="flex items-center text-sm text-gray-600">
                            <span className="font-medium mr-1">Duration:</span>
                            <span>
                                {(event.measurements.duration / 1e6).toFixed(2)}{' '}
                                ms
                            </span>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default App;
