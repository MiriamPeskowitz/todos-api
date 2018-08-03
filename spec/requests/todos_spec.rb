require 'rails_helper'

Rspec.describe "Todos API", type: :request do

# initialize test data

let!(:todos) {create_list(:todo, 10)}
let(:todo_id) { todos.first.id }

#test suite for GET /todos
describe 'GET todos' do
  #make http get request before each example 
  before { get '/todos'}

  it 'returns todos' do 
    expect(json).not_to_be_empty
    expect(json.size).to eq(10)

  end 

  it 'returns status code 200'
    expect(response).to have_http_status(200) 
  end 
end 

#test suite for GET /todos/:id
describe 'GET todos/:id' do
  before { get "/todos/#{todo_id}" }

  context 'when the record exists' do
    it 'returns the todo' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(todo_id)
    end 

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end 
  end 

  context 'when the record does not exist' do
    let(:todo_id) {100}

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end 

    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Todo/)
    end 
  end 
end

#Test suite for Post /todos 

describe 'Post /todos' do
  # valid payload
  let(:valid_attributes) { { title: 'Learn Elm', creaed_by: '1'}}
# why double braces? 
  context 'when the request is valid' do 
    before {post '/todos', params: valid_attributes }

    it 'creates a todo' do
      expect(json['title']).to eq('Learn Elm')
    end 

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end 
  end 

  context "when the request is invalid" do 
    before { post '/todos', params: {title: "Foobar"} }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end 

    it 'returns a validation failure message' do 
      expect(response.body) 
        .to match(/Validation failed: Created by can't be blank/)
      end 
    end 
  end 

  #why test suite separate for Put and Post? -- for editing 
  # Put /todos/:id  test suite 

  describe "Put /todos/:id" do 
    let(:valid_attribues) { { title: 'Shopping'}}

    context 'when the record exists' do 
      before { put "/todos/#{todo_id}", params: valid_attributes}

      it 'updates the record' do 
        expect(response.body).to be_empty
      end 

      it 'returns status code 204' do 
        expect(response).to have_http_status(204)
      end 
    end
  end 

  #test suite for delete /todos/:id

  describe 'DELETE /todos/:id' do 
    before {delete "/todos/#{todo_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end 
  end 
end