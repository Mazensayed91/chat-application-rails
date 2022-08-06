# Instachat <img src="https://user-images.githubusercontent.com/54520113/183217921-3a5e6cd2-ad2d-4d9e-9096-5e276b40149f.png" width="50" height="30">
Instachat is a chatting system that aims to make it easier to communicate with one another.

## Technology Stack
- Language: Ruby
- Frameworks: Rails
- DB: MySQL
- Caching: Redis
- Background Processing: ActiveJob
- Unit testing: Rspec

## Prerequisites

- Docker

## Getting Started

- Clone the repo ```https://github.com/Mazensayed91/chat-application-rails.git```
- ```cd chat-application-rails```
- Run ``` docker-compose up ```

- If you are using docker desktop you should be able to see response like this one:

![image](https://user-images.githubusercontent.com/54520113/183265020-b5da0012-8b93-4d2a-8548-7bc373ca63a9.png)



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

## Database
![image](https://user-images.githubusercontent.com/54520113/183237934-e57ebcbd-55ca-4818-a439-9f62952c999c.png)

## ActiveJob
We have many time consuming tasks that can block users from using the website and also assuming that the API will be used by multiple servers we decided to process creatation requests asynchronously in the background below you can find a list of jobs that we processing in the background.
Also, chat_count for application and message_count for chat doesn't have to be live

### Jobs
* CreateAppJob
* CreateChatJob
* CreateMessageJob
* UpdateChatsCountJob
* UpdateMessagesCountJob



## Redis

Since Redis stores its data on the primary memory, reading and writing are made faster than databases that store data on disks. This is why we used Redis as a cache in many applications, to provide results rapidly.

We are using Redis to cache:
* Applications
* Chats
* Messages


## Elasticserach

Elasticsearch allows you to store, search, and analyze huge volumes of data quickly and in near real-time and give back answers in milliseconds. It's able to achieve fast search responses because instead of searching the text directly, it searches an index.

That's why we used it to search in the messages of a specific chat.

## Application Unit Testing

| UnitTest                                  |                  Description                     | Expected Return |
| ------------------------------------------| -------------------------------------------------|-----------------|
|get_apps_spec                              | Gets all apps                                    |     200         |
