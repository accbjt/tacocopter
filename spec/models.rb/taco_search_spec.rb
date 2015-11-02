describe "TacoSeach" do
	context "tacos" do
		it "returns an Array" do
			expect(TacoSearch.tacos).to be_an_instance_of(Array)
		end 
		it "tacos count equals total tacos in DB" do
			expect(TacoSearch.tacos.count).to eq 18
		end
	end

	context "salsas" do
		it "returns an Array" do
			expect(TacoSearch.salsas).to be_an_instance_of(Array)
		end 
		it "tacos count equals total tacos in DB" do
			expect(TacoSearch.salsas.count).to eq 9
		end
	end
end