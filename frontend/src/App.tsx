// import { useChannel } from "./useChannel";
import { useCryptoChannel } from "./useCryptoChannel";

// interface TelemetryEvent {
//   measurements: {
//     duration: number;
//   };
//   metadata: {
//     conn: {
//       request_path: string;
//       method: string;
//     };
//     route: string;
//   };
// }

interface CryptoData {
  bitcoin: { usd: number };
  ethereum: { usd: number };
  ripple: { usd: number };
}

function App() {
  // const events = useChannel("telemetry_event");
  const cryptoPrices: CryptoData = useCryptoChannel("crypto_prices");

  return (
    <div className="min-h-screen bg-gray-100 p-8">
      <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
        <h2 className="text-2xl font-bold mb-4">Live Crypto Prices</h2>
        <div className="flex justify-around">
          {cryptoPrices.bitcoin && (
            <div className="text-center">
              <span className="text-xl font-semibold">Bitcoin:</span>
              <p className="text-2xl font-bold text-green-600">
                ${cryptoPrices.bitcoin.usd}
              </p>
            </div>
          )}
          {cryptoPrices.ethereum && (
            <div className="text-center">
              <span className="text-xl font-semibold">Ethereum:</span>
              <p className="text-2xl font-bold text-blue-600">
                ${cryptoPrices.ethereum.usd || "N/A"}
              </p>
            </div>
          )}
          {cryptoPrices.ripple && (
            <div className="text-center">
              <span className="text-xl font-semibold">Ripple:</span>
              <p className="text-2xl font-bold text-blue-600">
                ${cryptoPrices.ripple.usd || "N/A"}
              </p>
            </div>
          )}
        </div>
      </div>

          {/* Optional Telemetry that can be configured in the backend depending on the use case */}
      {/* <h1 className="text-4xl font-bold mb-8 text-center text-gray-800">
        Optional Real-time Telemetry Dashboard
      </h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {events.map((event, index) => (
          <div key={index} className="bg-white rounded-lg shadow-lg p-6 hover:shadow-xl transition-shadow duration-300">
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
                {(event.measurements.duration / 1e6).toFixed(2)} ms
              </span>
            </div>
          </div>
        ))}
      </div> */}
    </div>
  );
}

export default App;