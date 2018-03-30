require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'can save' do
      it "is valid with text, image, user_id and group_id" do
        message = build(:message)
        expect(message).to be_valid
      end

      it "is valid with text, user_id and group_id" do
        message = build(:message, text: nil)
        expect(message).to be_valid
      end

      it "is valid with text, user_id and group_id" do
        message = build(:message, image: nil)
        expect(message).to be_valid
      end
    end
    context "can not save" do
      it "is invalid without text and image" do
        message = build(:message, text: nil, image: nil)
        message.invalid?
        expect(message.errors[:text_or_image]).to include("を入力してください")
      end

      it "is invalid without group_id" do
        message = build(:message, group_id: nil)
        message.invalid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it "is invalid without user_id" do
        message = build(:message, user_id: nil)
        message.invalid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end
