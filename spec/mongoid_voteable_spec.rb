require "spec_helper"

describe Mongoid::Voteable do

  describe ".included" do

    it "adds votes and voters to the document" do
      fields = User.fields
      fields['votes'].should != nil
      fields['voters'].should != nil
    end

    it "defines the vote, voted?, vote_count and vote_average methods" do
      @post = Post.new
      @post.respond_to?("vote").should == true
      @post.respond_to?("voted?").should == true
      @post.respond_to?("vote_count").should == true
      @post.respond_to?("vote_average").should == true
    end

  end

  describe "vote" do

    before(:each) do
      @bob = User.create :name => "Bob"
      @sally = User.create :name => "Sally"
      @post = Post.create :name => "Announcement"
    end

    it "tracks votes" do
      @post.vote 1, @bob
      @post.vote 1, @sally
      @post.votes.should == 2
    end

    it "limits votes by user" do
      @post.vote 1, @bob
      @post.vote 5, @bob
      @post.votes.should == 1
    end

    it "works with both positive and negative votes" do
      @post.vote 5, @bob
      @post.vote -3, @sally
      @post.votes.should == 2
    end

    it "should know if someone has voted" do
      @post.vote 5, @bob
      @post.voted?(@bob).should == true
      @post.voted?(@sally).should == false
    end

    it "should know how many votes have been cast" do
      @post.vote 5, @bob
      @post.vote -5, @sally
      @post.vote_count.should == 2
    end

    it "should calculate the average vote" do
      @post.vote 10, @bob
      @post.vote 5, @sally
      @post.vote_average.should == 7.5
    end

    it "should average if the result is zero" do
      @post.vote 1, @bob
      @post.vote -1, @sally
      @post.vote_average.should == 0
    end

    it "should not average if we have no votes" do
      @post.vote_average.nil?.should == true
    end

    it "should properly update the collection" do
      @post.vote 8, @bob
      @post.vote -10, @sally
      post = Post.where(:name => "Announcement").first
      post.votes.should == -2
      post.voted?(@bob).should == true
      post.voted?(@sally).should == true
      post.vote_count.should == 2
      post.vote_average.should == -1
    end

  end

end

