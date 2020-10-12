require 'rails_helper'

RSpec.describe Post, "Postモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "投稿内容が保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  context "空白の場合" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      post = Post.new(content: '', condition: 'hoge')
      expect(post).to be_invalid
      expect(post.errors[:content]).to include("を入力してください")
    end
    it "conditionが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってくるか" do
      post = Post.new(content: 'hoge', condition: '')
      expect(post).to be_invalid
      expect(post.errors[:condition]).to include("を入力してください")
    end
  end

  describe "conditionを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit root_path
      fill_in "post[condition]", with: ""
    end

    it "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "を入力してください"
    end
  end

  describe "contentを空白で投稿した場合に画面にエラーメッセージが表示されるか" do
    before do
      visit posts_path
      fill_in "post[content]", with: ""
    end

    it "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "を入力してください"
    end
  end

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'conditionカラム' do
      it '空欄でないこと' do
        post.condition = ''
        expect(book.valid?).to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        post.content = ''
        expect(book.valid?).to eq false
      end
      it '20文字以下であること' do
        post.content = Faker::Lorem.characters(number: 21)
        expect(post.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
