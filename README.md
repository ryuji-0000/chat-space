# Database design


## users table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, add_index unique: true|
|email|text|null: false, add_index unique: true|

### Association
- has_many :groups, through: :group_user
- has_many :group_users
- has_many :messages

validates :name, email, presence: true



## groups table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, add_index unique: true|

### Association
- has_many :users, through: :group_user
- has_many :group_users
- accepts_nested_attributes_for :group_user
- has_many :messages

validates :name, presence: true


## group_user table

|Column|Type|Options|
|------|----|-------|
|group_id|references|foreign_key: true|
|user_id|references|foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user



## messages table

|Column|Type|Options|
|------|----|-------|
|text|string||
|image|string||
|group_id|references|foreign_key: true|
|user_id|references|foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user


