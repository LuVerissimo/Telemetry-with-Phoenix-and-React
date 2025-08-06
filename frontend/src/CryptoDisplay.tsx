import { useCryptoChannel } from './useCryptoChannel';

type CryptoKey = 'bitcoin' | 'ethereum' | 'ripple';

interface CryptoData {
  bitcoin?: { usd: number };
  ethereum?: { usd: number };
  ripple?: { usd: number };
}

const CRYPTO_COINS: Record<CryptoKey, string> = {
  bitcoin: 'bitcoin',
  ethereum: 'Ethereum',
  ripple: 'Ripple',
};


export const CryptoDisplay = () => {
  const cryptoPrices: CryptoData = useCryptoChannel('crypto_prices');

  return (
    <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
      <h2 className="text-2xl font-bold mb-4">Crypto Display</h2>
      <div className="flex justify-around">
        {(Object.keys(CRYPTO_COINS) as CryptoKey[]).map((coinKey) => {
          const coinName = CRYPTO_COINS[coinKey];
          const price = cryptoPrices?.[coinKey]?.usd;
          return (
            <div key={coinKey} className="text-center">
              <span className="text-xl font-semibold">{coinName}:</span>
              <p className="text-2xl font-bold text-green-600">
                {price !== undefined ? `$${price}` : 0}
              </p>
            </div>
          );
        })}
      </div>
    </div>
  );
};

