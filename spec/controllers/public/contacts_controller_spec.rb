RSpec.describe "四則演算" do
  context "足し算" do
    it "1+1=2" do
      expect(1+1).to eq 2
    end
    it "10-9=1" do
      expect(10-9).to eq 1
    end
  end
end

# describe "GET #new" do
#   it "正しいviewに遷移する" do
#   end

#   it "@contactが期待される値を持っているか" do
#   end
# end

# describe "Post #create" do
#   context "@contactが保存できた時" do
#     it "データベースに値が保存される" do
#     end

#     it "正しいviewに変遷する" do
#     end
#   end

#   context "@contactが保存できなかった時" do
#     it "データベースに値が保存されない" do
#     end

#     it "正しいビューに変遷する" do
#     end
#   end
# end

