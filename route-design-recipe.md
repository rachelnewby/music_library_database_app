# Post /albums Route Design Recipe

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method: Post
  * the path: /albums
  * any query parameters (passed in the URL): artist_id 
  * or body parameters (passed in the request body)

## 2. Design the Response

Your response might return plain text, JSON, or HTML code. 

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

<!-- No output>
```

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /albums/?id=2

# Expected response:

Response for 200 OK
```

```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /albums" do
    it "returns 200 OK" do
      response = get('/albums')
      expect(response.status).to eq(200)
      
    end
  end
  
  context "POST /albums" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = post('/albums', title: 'Voyage', release_year: 2022, artist_id: 2)

      expect(response.status).to eq(200)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.