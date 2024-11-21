# Maka_assessment

## Technologies Used:
- Flutter
- Dart
- Postman
- FVM

## Versions:
- **Flutter:** 3.13.6
- **Dart:** 3.1.3
- **DevTools:** 2.25.0

> **NOTE:** In this project, I used Flutter Version Management (FVM). You can see the version in the path: `.fvm/fvm_config.json` under "flutterSdkVersion”.

## Project Requirements:
As we strive to become the premier platform for discovering and purchasing the latest in fashion & beauty, the cornerstone of our platform will be the live selling shows hosted by various content creators. As these shows progress, consumers can purchase showcased products in real-time. Additionally, content creators have the ability to discuss the product's sales performance live and inform viewers about remaining inventory quantities. This provides an opportunity for them to encourage immediate purchases, especially when stock is running low.

To facilitate this dynamic experience, we have several APIs at our disposal. Their documentation can be found.
[API POSTMAN](https://documenter.getpostman.com/view/16186116/UVCCfPvU).

### Inventory Screen:
- The user can add current stock inventory for an item.
- The inventory can accommodate a list of one or multiple items. If the `itemID` already exists, both `itemName` and inventory details will be updated accordingly.
  
  **API Endpoint:** `POST /inventory`
  ```json
  [ { "itemID": 12345, "itemName": "Fancy Dress", "quantity": 10 } ]
  
### Live Show Screen:
- Users can view all items sold during the live show.
- For the current scope, assume there will always be only one show with the ID 222. This show will persist and will not conclude or be removed.

  **API Endpoint:** `GET /show/[show_ID]`

- Users have the option to purchase an individual item during the live show. The system checks available inventory and, if stock permits, deducts one item. This sale is then recorded under show `show_ID` and returns a success status. If inventory is insufficient, an HTTP 409 status code is returned along with a relevant message.

  **API Endpoint:** `POST /show/[show_ID]/buy_item/[item_ID]`

