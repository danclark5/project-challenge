require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    it 'displays recent dogs' do
      2.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end

    it 'displays first five dogs' do
      6.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end
  end

  describe '#new' do
    let(:params) { { dog:
                     {
                        name: "Sunny",
                        description: "",
                        image: images
                     }
                   } }
    let(:images) {[fixture_file_upload('images/speck.jpg', 'image/jpg')]}

    it 'creates a new dog record' do
      expect {
        post :create, params: params
      }.to change(Dog, :count).by(1)
    end

    it 'creates an image record' do
      post :create, params: params
      expect(Dog.first.images.count).to eq(1)
    end

    context 'multiple images uploaded' do
      let(:images) {[
        fixture_file_upload('images/speck.jpg', 'image/jpg'),
        fixture_file_upload('images/sunny.jpg', 'image/jpg')
      ]}
      it 'creates multiple images for the new dog record' do
        post :create, params: params
        expect(Dog.first.images.count).to eq(2)
      end
    end
  end
end
