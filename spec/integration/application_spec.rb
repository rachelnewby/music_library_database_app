require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns all albums with title and release year" do
      response = get('/albums')
      
      expect(response.status).to eq (200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a>')
      expect(response.body).to include('<a href="/albums/4">Super Trouper</a>')
    end

    it "/albums/:id returns HTML containing a selected album's details" do
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end


    it "renders a form with the /albums/new route" do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add an Album:</h1>')
      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end


  context "POST /albums" do
    it "adds an album to the database table - verified with GET" do
      response = post(
        '/albums', 
        title: 'Voyage', 
        release_year: '2022', 
        artist_id: '2'
      )

      expect(response.status).to eq(200)
    end

    it "responds with 400 status if parameters are invalid" do
      response = post("/albums", title: nil, release_year: nil)

      expect(response.status).to eq 400
    end
  end

  context 'POST /artist' do
    it "creates a new artist row in the artist table" do
      response = post("/artist", name: "The Corrs", genre: "Pop")

      expect(response.status).to eq(200)

      response = get('/artists')
      expect(response.body).to include('The Corrs')
    end

    it "returns 400 error if parameters are invalid" do
      response = post("/artist", name: nil, genre: nil)
      expect(response.status).to eq 400
    end
  end

  context "GET /artists/:id" do
    it "returns a HTML page with details for a single artist" do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('<p>Genre: Rock</p>')
    end
  end

  context "GET /artists/new" do
    it "will render a form to take details of new artist" do
      response = get("/artists/new")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add an Artist:</h1>')
      expect(response.body).to include('<form action="/artist" method="POST">')
    end
  end

  context "GET /artists" do
    it "returns a HTML page with links to each artist" do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/1">Pixies</a>')
      expect(response.body).to include('<a href="/artists/2">ABBA</a>')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')
    end
  end
end
 