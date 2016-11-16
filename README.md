# RequestRegistry

### 1. Create registry
```ruby
class AppRegistry
  extend RequestRegistry.new(:user, :account)
end
```
### 2. Use it anywhere
Set it in controller
```ruby
class ApplicationController < ActionController::Base
  before_action :provide_registry_information

  private

  def provide_registry_information
    AppRegistry.user = current_user
    AppRegistry.account = 'my awesome account'
  end
end
```
And get it in model
```ruby
class Post < ActionController::Base
  belongs_to :author
  before_save :set_author

  private

  def set_author
    self.author = AppRegistry.user.presence
  end
end
```
