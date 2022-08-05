# Instachat <img src="https://user-images.githubusercontent.com/54520113/183217921-3a5e6cd2-ad2d-4d9e-9096-5e276b40149f.png" width="50" height="30">
Instachat is a chatting system that aims to make it easier to communicate with one another.

## Technology Stack
- Language: Ruby
- Frameworks: Rails
- DB: SQLite
- Caching: Redis
- Background Processing: ActiveJob

## Prerequisites

- Ruby 3.0.2
- Rails 7

## Getting Started

- Clone the repo ```https://github.com/Mazensayed91/fleet-management-system.git```
- ```cd chat-application-rails```
- Bundle install


## API Reference

### Getting Started

* Base URL:This application is hosted locally at `http://localhost:3000/`. A public URL will be added here once the application is deployed.

### Error Handling

Errors are returned as JSON and are formatted in the following manner:<br>
```
    {
        "error": "404",
        "message": "Application not found"
    }
``` 
```
    {
        "error": "404",
        "message": "Chat not found"
    }
```

```
    {
        "error": "404",
        "message": "Can't create chat for this app as it doesn't exist"
    }
```

Example errors the user may incounter using instachat:

* 400 – bad request
* 404 – resource not found

### Endpoints

#### GET /api/v1/applications

* General: Returns a list applications that fall in a given range.
* Sample: `curl http://localhost:3000/api/v1/applications`<br>

* Message Header:
  ```
         {
           "Content-Type": "application/json",
           "Accept": "application/json"
         }
  ```
* Return:
```
        {
    "status": "SUCCESS",
    "message": "Loaded Apps",
    "data": [
        {
            "name": "first app",
            "token": "OV4cGVOdopCdt5KiLWTOUw",
            "chats_count": 0,
        },
        {
            "name": "second app",
            "token": "EUh2PMNvIZ_W4YFEau13gQ",
            "chats_count": 5,
        },
        {
            "name": "third app",
            "token": "BzeVfR7BDiqzZKU8WioKBw",
            "chats_count": 0,
        },
        {
            "name": "forth app",
            "token": "DmHIAUCtKbxTwnyCtVHNWctsOYTwkvuWLHaCRimpaznzyVEdXr",
            "chats_count": 0,
        }
    ]
}
```

#### POST /api/v1/applications

* General:
* Sample: `curl http://localhost:3000/api/v1/applications`<br>
* Message body:
  ```
        {
           "name": "New Appp"
        }
  ```
* Message Header:
  ```
         {
           "Content-Type": "application/json",
           "Accept": "application/json"
         }
  ```
* Return:
  ```
         {
            "status": "SUCCESS",
            "message": "app is being created",
            "data": {
                "token": "GGbx53OyBW1p5xYohL_d-w",
                "name": "New Appp"
            }
         }
   ```

#### POST /api/v1/applications/:application_token/chats

* General:
* Sample: `curl http://localhost:3000/api/v1/applications/:application_token/chats`<br>

* Return:
  ```
        {
            "status": "SUCCESS",
            "message": "Creating app",
            "data": {
                "chat_num": 1,
                "created_at": "2022-08-05T09:08:46.037Z"
            }
        }
   ```
 * If app doesn't exist:
   ```
       {
            "status": "App does not exit"
       }
   ```
   

#### GET /api/v1/applications/:application_token/chats

* General:
* Sample: `curl http://localhost:3000/api/v1/applications/:application_token/chats`<br>

* Return:
  ```
    {
        "status": "SUCCESS",
        "message": "Loaded Apps",
        "data": [
            {
                "chat_num": 1,
                "messages_count": 8,
                "created_at": "2022-08-05T09:08:46.037Z"
            },
            {
                "chat_num": 2,
                "messages_count": 13,
                "created_at": "2022-08-05T09:08:46.037Z"
            }
        ]
    }
   ```
      
#### GET /api/v1/applications/:application_token/chats/:chat_num/messages

* General:
* Sample: `curl http://localhost:3000/api/v1/applications/:application_token/chats/:chat_num/messages`<br>

* Return:
  ```
    {
        "status": "SUCCESS",
        "message": "Loaded messages",
        "data": [
            {
                "message_num": 1,
                "content": "test 1",
                "created_at": "2022-08-05T09:33:38.514Z"
            },
            {
                "message_num": 2,
                "content": "test 2",
                "created_at": "2022-08-05T09:34:08.970Z"
            },
            {
                "message_num": 3,
                "content": "test 3",
                "created_at": "2022-08-05T09:35:58.034Z"
            },
            {
                "message_num": 4,
                "content": "test 4",
                "created_at": "2022-08-05T15:10:56.622Z"
            }
        ]
    }
   ```
   
#### POST /api/v1/applications/:application_token/chats/:chat_num/messages

* General:
* Sample: `curl http://localhost:3000/api/v1/applications/:application_token/chats/:chat_num/messages`<br>

* Message body:
  ```
        {
           "content": "test 5"
        }
  ```
* Message Header:
  ```
         {
           "Content-Type": "application/json",
           "Accept": "application/json"
         }
  ```

* Return:
  ```
    {
        "status": "SUCCESS",
        "message": "Create message",
        "data": {
            "message_num": 5,
            "content": "test 5"
        }
    }
   ```
   
#### POST /api/v1/applications/:application_token/chats/:chat_num/messages/search

* General:
* Sample: `curl http://localhost:3000/api/v1/applications/:application_token/chats/:chat_num/messages/search`<br>

* Message body:
  ```
        {
           "query": "test"
        }
  ```
* Message Header:
  ```
         {
           "Content-Type": "application/json",
           "Accept": "application/json"
         }
  ```

* Return:
  ```
    {
        "status": "SUCCESS",
        "message": "Matched Messages",
        "data": [
            {
                "message_num": 1,
                "content": "test 1",
                "chat_id": 3
            },
            {
                "message_num": 2,
                "content": "test 2",
                "chat_id": 3
            },
            {
                "message_num": 3,
                "content": "test 3",
                "chat_id": 3
            },
            {
                "message_num": 4,
                "content": "test 4",
                "chat_id": 3
            },
            {
                "message_num": 5,
                "content": "test 5",
                "chat_id": 3
            }
        ]
    }
   ```
   
   
