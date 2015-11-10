require "spec_helper"

describe Lita::Handlers::Pun, lita_handler: true do
  it { routes_command("give me a pun").to(:pun) }
  it { routes_command("what's the pun of the day").to(:pun_of_the_day) }

  describe "#pun" do
    it "responds with a random pun" do
      send_command("give me a pun")
      expect(replies.last).to match(/.+!/)
    end
  end

  describe "#pun_of_the_day" do
    it "responds with the pun of the day" do
      send_command("what's the pun of the day")
      expect(replies.last).to match(/.+!/)
    end
  end
end
