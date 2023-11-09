module UsersHelper

    def fetch_first_n_users(n)
        User.limit(n)
    end

end