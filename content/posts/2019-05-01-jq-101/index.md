---
title: "JQ 101"
date: "2019-05-01"
categories: 
  - "dev"
  - "howto"
  - "oss"
---

JQ is an amazing tool that allows you to manipulate JSON via the command line / bash.

To be frank I was a bit weirded out by people praising something so 'trivial' back in the day, but then I realized how powerful this thing actually is. Manipulating JSON coming from web background may seem really simple task, but when you go to bash, it is ... nightmare.

JQ makes things doable in surprisingly simple way.

The thing it is that it can be a bit hard to start with. Some people have asked me to provide them with several examples so they can have something to build on top of when developing their own stuff.

These are the basics, if you have mastered everything listed here, your logical next step would be to read the [official docs](https://stedolan.github.io/jq/manual/) like a real dev

So, this is my cheat sheet:

## [](http://localhost:1337/#how-to-use-54)

## How to use

#### [](http://localhost:1337/#invocation-54)

#### Invocation

You can `cat` a file and pipe it to JQ like:

```
cat file.json | jq 'something'
```

but it is generally preferred to do it like this:

```
jq 'something' < file.json
```

I personally prefer to add `-r` flag to JQ so it outputs `raw`

```
jq  -r 'something' < file.json
```

### [](http://localhost:1337/#sample-data-54)

### Sample data

We are going to be working with this JSON for most of the examples

```
{
    "data": [
        {
            "email": "user1@example.com",
            "username": "user1"
        },
        {
            "email": "user2@example.com",
            "username": "user2"
        }
    ],
    "users": [
        {
            "email": "user1@example.com",
            "user.name": "user1"
        },
        {
            "email": "user2@example.com",
            "user.name": "user2"
        }
    ]
}
```

## [](http://localhost:1337/#examples-54)

## Examples

### [](http://localhost:1337/#basic-54)

### Basic

#### [](http://localhost:1337/#simple-select-everything-54)

#### Simple select everything

```
jq -r '.' < file.json
```

will give you the root of the document. Doesn't matter if it is an object or array

#### [](http://localhost:1337/#select-property-of-an-object-54)

#### Select property of an object

```
jq -r '.data' < file.json
```

returns an array containing all users in '.data'

#### [](http://localhost:1337/#select-first-user-in-data-54)

#### Select first user in data

```
jq -r '.data[0]' < file.json
```

returns first object in 'data' array

#### [](http://localhost:1337/#select-all-usernames-is-data-54)

#### Select all usernames is '.data'

```
jq -r '.data[].username' < file.json
```

returns

```
user1
user2
```

#### [](http://localhost:1337/#select-all-usernames-of-users-array-when-keys-contain-dots-54)

#### Select all usernames of 'users' array when keys contain dots

```
jq -r '.users[]["user.name"]' < file.json
```

returns

```
user1
user2
```

### [](http://localhost:1337/#selectors-17)

### Selectors

#### [](http://localhost:1337/#getting-keys-of-an-object-54)

#### Getting keys of an object

```
jq -r '.|keys' < file.json
```

gives you an array containing all keys `["data", "users"]`

#### [](http://localhost:1337/#getting-keys-of-object-on-new-lines-54)

#### Getting keys of object on new lines

```
jq -r '.|keys[]' < file.json
```

returns

```
data
users
```

#### [](http://localhost:1337/#select-only-users-called-user1-from-data-53)

#### Select only users called 'user1' from 'data'

```
jq -r '.data[] | select(.username="user1")'
```

gives you `{"username": "user1", "email": "user1@example.com"}`

#### [](http://localhost:1337/#select-the-emails-of-all-users-called-user1-49)

#### Select the emails of all users called 'user1'

```
jq -r '.data[] | select(.username="user1") | .email'
```

### [](http://localhost:1337/#create-json-47)

### Create JSON

#### [](http://localhost:1337/#create-object-with-key-username-and-value-user1-47)

#### Create object with key username and value 'user1'

```
jq -n --arg mykey username --arg myval user1 '{($mykey):$myval}'
```

#### [](http://localhost:1337/#append-property-to-object-46)

#### Append property to object

```
jq -n --arg mykey username --arg myval user1 '{($mykey):$myval}' | jq -r '. |= . + {"email": "user1@example.com"}'
```

or simpler:

```
echo '{"username": "user1"}' | jq -r '. |= . + {"email": "user1@example.com"}'
```

both result in:

```
{
  "username": "user1",
  "email": "user1@example.com"
}
```

#### [](http://localhost:1337/#change-value-of-object-property-37)

#### Change value of object property

```
jq -n '{ "username": "user1"}' | jq -r '.username="user11"'
```

### [](http://localhost:1337/#create-array-45)

### Create array

```
jq -n '[]'
```

same as

```
echo '[]' | jq -r '.'
```

#### [](http://localhost:1337/#set-value-of-array-element-44)

#### Set value of array element

```
jq -n '[1,2,3]' | jq -r '.[2] |=  5'
```

outputs `[1,2,5]`

#### [](http://localhost:1337/#add-element-to-array-of-unknown-length-43)

#### Add element to array (of unknown length)

```
jq -n '[1,2,3]' | jq -r '.[.|length] |=  4'
```

result `[1,2,3,4]`
