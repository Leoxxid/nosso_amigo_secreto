class RaffleService
  def initialize(campaign)
    @campaign = campaign
  end

  def call
    return false if @campaign.members.count < 3

    results = {}
    members_list = @campaign.members
    friends_list = @campaign.members
    i = 0
    while(members_list.count != i)
      m = members_list[i]
      i += 1

      loop do
        friend = friends_list.sample

        if friends_list.count == 1 and friend == m
          results = {}
          members_list = @campaign.members
          friends_list = @campaign.members
          i = 0
          break
        elsif friend != m and results[friend] != m
          results[m] = friend
          friends_list -= [friend]
          break
        end
      end
    end
    results
  end
end
