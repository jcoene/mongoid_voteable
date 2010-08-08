module Mongoid
  module Voteable

    VERSION = "0.1.0"

    extend ActiveSupport::Concern

    included do
      field :votes, :type => Integer, :default => 0
      field :voters, :type => Array, :default => []
    end

    module InstanceMethods

      def vote(num, voter)

        unless voted? voter
          self.votes += num.to_i
          self.voters << voter._id
          collection.update(  { "_id" => _id, "voters" => { "$ne" => voter._id } },
                              { "$inc" => { "votes" => num.to_i }, "$push" => { "voters" => voter._id } } )
        end

      end

      def voted?(voter)
        voters.include? voter._id
      end

      def vote_count
        voters.count
      end

      def vote_average
        if voters.blank?
          nil
        else
          votes.to_f / voters.count
        end
      end

    end
  end
end
