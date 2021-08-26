require "rails_helper"

RSpec.describe "postコントローラーのテスト", type: :request do
  describe "ページの表示テスト" do
    context "homeが正しく表示される" do
      before do
        get root_path
      end
      it "リクエストは200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されていること" do
        expect(response.body).to include("Home")
      end
    end
  end
end