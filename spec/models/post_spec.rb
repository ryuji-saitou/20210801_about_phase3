require 'rails_helper'

RSpec.describe "Postモデルのテスト" do
  describe "バリデーションのテスト" do
    #factoriesで作成したダミーデータを使用する
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    let!(:comment) { build(:comment, user_id: user.id, post_id: post.id) }

    # test_postを作成して空欄での登録ができるかを確認する
    subject { test_post.valid? }
    let(:test_post) { post }

    context "actionカラム" do
      it "空欄でないこと" do
        test_post.action = ""
        is_expected.to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "userモデルとの関係" do
      it "N:1となっている" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    # context "PostCommentモデルとの関係" do
    #   it "1:Nとなっている" do
    #     expect(Post.reflect_on_association(:comment).macro).to eq :has_many
    #   end
    # end
  end
end
