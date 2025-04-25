import { firebaseConfig } from "../utils/FirebaseConfig";

const url = "https://api.izzy.cz";

export const config = {
  defaultLanguage: "CZ",
  url: {
    base: url,
    api: `${url}/v1`,
    conversationWS: `${url}/conversations`,
  },
  mediaUrl: "https://izzy-production-data.s3.eu-central-1.amazonaws.com/prod",
  stripeUrl:
    "pk_live_51KVwg0DaAyuRxxlprr3G8ZtL5tW3gpAZm2LoeJcf7p7xSYdhqC9xphElbFKodqPjrHrCKQwZInnXINIkuDgUs8ms00wYLZENCd",
  firebaseConfig: firebaseConfig
};
