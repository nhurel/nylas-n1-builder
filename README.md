# N1 Builder
This image lets you build a custom package for the N1 email client.
It gives you the possibility to customize N1 and make it point to a self-hosted instance of the sync engine.
For more information about N1 email client and all nylas production, go to https://www.nylas.com
and look at their repositories https://github.com/nylas/sync-engine and https://github.com/nylas/N1

# Usage
This image is designed to run a one-shot container and destroy it.
Assuming your sync engine is available at `http://your-hostname.com:5555`,  run :
```bash
docker run -e ENGINE_URL=http://your-hostname.com:5555 --name n1 nhurel/n1-builder
docker cp n1:/tmp/nylas-build/nylas-0.3.26-amd64.deb .
docker rm n1
```

# Install N1
Once your package is built, simply run the following command to install it :
```bash
dpkg -i nylas-0.3.26-amd64.deb
```

# Confugure N1 to use your self-hsoted sync engine
Edit or create the `~/.nylas/config.cson` file and define `selfhosted` for the `env` attribute. For example :
```cson
"*":
  env: "selfhosted"
  nylas:
    accounts: [
      {
        server_id: "{ACCOUNT_ID_1}"
        object: "account"
        account_id: "{ACCOUNT_ID_1}"
        name: "{YOUR NAME}"
        provider: "{PROVIDER_NAME}"
        email_address: "{YOUR_EMAIL_ADDRESS}"
        organization_unit: "{folder or label}"
        id: "{ACCOUNT_ID_1}"
      }
      {
        server_id: "{ACCOUNT_ID_2}"
        object: "account"
        account_id: "{ACCOUNT_ID_2}"
        name: "{YOUR_NAME}"
        provider: "{PROVIDER_NAME}"
        email_address: "{YOUR_EMAIL_ADDRESS}"
        organization_unit: "{folder or label}"
        id: "{ACCOUNT_ID_2}"
      }
    ]
    accountTokens:
      "{ACCOUNT_ID_1}": "{ACCOUNT_ID_1}"
      "{ACCOUNT_ID_2}": "{ACCOUNT_ID_2}"
```

More information about running N1 against a self hosted sync engine can be found here : https://github.com/nylas/N1/blob/master/CONTRIBUTING.md#running-against-open-source-sync-engine
