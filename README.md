### Broadcast events with Phoenix and React
  The basic idea is using Phoenix to broadcast information via sockets and streaming data from whatever you configure.

  In this example, I used the free GeckoCoin API. You can obtain a token by quickly making an account.
  
  https://www.coingecko.com/en/api
  It took less than a minute. You can enter nonsense in the reasoning of "why you want a key". Include it in your env file as "COINGECKO_API_KEY=SAMPLE"

### Cool things while learning
  - Supervision trees babysits other processes and restarts them whenever they crash.
    - I created a couple of modules for broadcasting crypto updates  
```

defmodule TelemetryDashboard.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
     ...
      {Phoenix.PubSub, name: TelemetryDashboard.PubSub},
      TelemetryDashboard.CryptoBroadcaster,
      TelemetryDashboard.TelemetryBroadcaster,
      ...
      TelemetryDashboardWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: TelemetryDashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end
  ...
end
```
- Extensive logging via PubSubBroadcast library
    - Debugging was easy the entire time. There a moment when my payload didn't come through but my sockets were being listened to. I received a suggestion in the console to push updates in my telemetry_channel file.   
    
### Get Started 

Git clone or SSH

## Split terminal into two views in VSCode (ctrl+shift+5) 
  ### First View
    - cd telemetry_dashboard
    - mix deps.get
    - mix compile
    - mix phx.server
  ### Second View 
    OR [drag/drop/open the `test_crypto_channel.html` file into the browser to skip the npm server]
    - cd frontend
    - npm install
    - npm start
Once your env file is configured. You should see live updates.
I throttled the API pull to reduce timeout so adjust it accordingly or buy a plan.    
In the future, I'm going to explore a heavier project involving Ground Satellites.
