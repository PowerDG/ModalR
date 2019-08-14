





###	新建角色

```
{
  "name": "Staff",
  "displayName": "StaffMember",
  "normalizedName":"研究院成员",
  "description": "string",
  "permissions": ["Identifications.Staff.Members" 
  ]
}
3
{
  "name": "Guest",
  "displayName": "Guest",
  "normalizedName":"访客",
  "description": "string",
  "permissions": [ "Identifications.Staff.Guest"
  ]
}
4
```



###	新建员工

```
{
  "userName": "wsx2019",
  "name": "wangshuxin",
  "surname": "wsx",
  "emailAddress": "wsx2019@qq.com",
  "isActive": true,
  "roleNames": [
    "Staff"
  ],
  "password": "123456"
}
，
{
  "userName": "Test001",
  "name": "Test001",
  "surname": "wsx",
  "emailAddress": "Test001@qq.com",
  "isActive": true,
  "roleNames": [
    "Staff"
  ],
  "password": "123456"
}

{
  "userName": "Test002",
  "name": "Test002",
  "surname": "wsx",
  "emailAddress": "Test002@qq.com",
  "isActive": true,
  "roleNames": [
    "Staff"
  ],
  "password": "123456"
}

{
  "userName": "Guest001",
  "name": "Guest001",
  "surname": "wsx",
  "emailAddress": "Guest001@qq.com",
  "isActive": true,
  "roleNames": [
    "Guest"
  ],
  "password": "123456"
}
```

```
{
  "userName": "Guest002",
  "name": "Guest002",
  "surname": "wsx",
  "emailAddress": "Guest002@qq.com",
  "isActive": true,
  "roleNames": [
    "Staff"
  ],
  "password": "123456"
}6
-------
{
 "userName": "Guest002",
  "name": "Guest002",
  "surname": "wsx",
  "emailAddress": "Guest002@qq.com",
  "isActive": true,
  "fullName": "string",
  "lastLoginTime": "2019-06-27T07:32:57.251Z",
  "creationTime": "2019-06-27T07:32:57.251Z",
  "roleNames": [
    "Guest"
  ],
  "id": 6
}
```





### 修改角色

```
{
   "name": "Staff",
        "displayName": "StaffMember",
        "normalizedName": "STAFF",
        "description": "研究院成员",
  "permissions": [
  " Identifications.Staff.Members"
  ],
  "id": 5
}

```

```json
	
Response body
Download

{
  "result": {
    "totalCount": 1,
    "items": [
      {
        "name": "Admin",
        "displayName": "Admin",
        "normalizedName": "ADMIN",
        "description": null,
        "permissions": [
          "Pages.Users",
          "Pages.Roles",
          "Pages.Tenants",
          " Identifications.Staff.Init",
          "Pages",
          " Identifications.Staff.Members",
          " Identifications.Staff.Guest",
          " Identifications.Staff.Assistant"
        ],
        "id": 1
      }
    ]
  },
  "targetUrl": null,
  "success": true,
  "error": null,
  "unAuthorizedRequest": false,
  "__abp": true
}
```







