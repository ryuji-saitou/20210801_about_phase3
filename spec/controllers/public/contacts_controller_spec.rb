class User
  def initialize(name:, age:)
    @name = name
    @age = age
  end
  def greet
    if @age <= 12
      "ぼくは#{@name}だよ。"
    else
      "僕は#{@name}です。"
    end
  end
end

describe User do
  describe "#greet" do
    let(:user) { User.new(params)}
    let(:params) { { name: "名前", age: age} }
    context "12歳以下の場合" do
      let(:age) { 12 }
      it "ひらがなで表示" do
        expect(user.greet).to eq "ぼくは名前だよ。"
      end
    end
    context "13歳以上の場合" do
      let(:age) { 13 }
      it "漢字で表示" do
        expect(user.greet).to eq "僕は名前です。"
      end
    end
  end
end

# describe User do
#   describe "#greet" do
#     let(:user) { User.new(params) }
#     let(:params) { { name: "名前" } }
#     context "12歳以下の場合" do
#       before do
#         params.merge!(age: 12)
#       end
#       it "ひらがなで表示" do
#         expect(user.greet).to eq "ぼくは名前だよ。"
#       end
#     end
#     context "13歳以上の場合" do
#       before do
#         params.merge!(age: 13)
#       end
#       it "漢字で表示" do
#         expect(user.greet).to eq "僕は名前です。"
#       end
#     end
#   end
# end

# describe User do
#   describe "#greet" do
#     let(:params) { { name: "名前" } }
#     # ▲"{ }"について...外側はRubyブロック、内側はハッシュリテラルを指す
#     # let(:params) do
#     #   hash = {}
#     #   hash[:name] = "名前"
#     #   hash
#     # end
#     context "12歳以下の場合" do
#       before do
#         params.merge!(age: 12)
#       end
#       it "ひらがなで回答" do
#         user = User.new(params)
#         expect(user.greet).to eq "ぼくは名前だよ。"
#       end
#     end
#     context "13以上の場合" do
#       before do
#         params.merge!(age: 13)
#       end
#       it "漢字で回答" do
#         user = User.new(params)
#         expect(user.greet).to eq "僕は名前です。"
#       end
#     end
#   end
# end

# describe User do
#   describe "#greet" do
#     before do
#       @params = {name: "名前"}
#     end
#     context "12歳以下の場合" do
#       before do
#         @params.merge!(age: 12)
#       end
#       it "ひらがなで答えること" do
#         user = User.new(@params)
#         expect(user.greet).to eq "ぼくは名前だよ。"
#       end
#     end
#     context "13歳以下の場合" do
#       before do
#         @params.merge!(age: 13)
#       end
#       it "漢字で答えること" do
#         user = User.new(@params)
#         expect(user.greet).to eq "僕は名前です。"
#       end
#     end
#   end
# end


# describe User do
#   describe "#greet" do
#     before do
#       @params = { name: "名前"}
#     end
#     context "12歳以下の場合" do
#       it "ひらがなで回答" do
#         user = User.new(@params.merge(age: 12))
#         expect(user.greet).to eq "ぼくは名前だよ。"
#       end
#     end
#     context "13歳以上の場合" do
#       it "漢字で回答" do
#         user = User.new(@params.merge(age: 13))
#         expect(user.greet).to eq "僕は名前です。"
#       end
#     end
#   end
# end

# describe User do
#   describe "#greet" do
#     context "12歳以下の場合" do
#       it "ひらがなで回答" do
#         user = User.new(name: "名前", age: 12)
#         expect(user.greet).to eq "ぼくは名前だよ。"
#       end
#     end
#     context "13歳以上の場合" do
#       it "漢字で回答" do
#         user = User.new(name: "名前", age: 13)
#         expect(user.greet).to eq "僕は名前です。"
#       end
#     end
#   end
# end

# describe User do
#   describe "#greet" do
#     it "12歳以下なら「ぼくは」" do
#       user = User.new(name: "名前", age: 12)
#       expect(user.greet).to eq "ぼくは名前だよ。"
#     end
#     it "13歳以上なら「僕は」" do
#       user = User.new(name: "名前", age:13)
#       expect(user.greet).to eq "僕は名前です。"
#     end
#   end
# end