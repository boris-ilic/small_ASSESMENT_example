class Env {
  static const baseUrl = String.fromEnvironment("baseUrl",
      defaultValue: 'https://us-central1-inventory-ts-firestore.cloudfunctions.net/api');
}
