class Ability
  include CanCan::Ability

  def initialize(admin)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    if admin
      # logged in as admin - manage actions on per role basis
      if admin.super?
        # can manage just about everything
        can :manage, :all
      elsif admin.moderator?
        # can manage products / category
        can :manage, [Product, Category, ActsAsTaggableOn::Tag]
      elsif admin.editor?
        # can view / create / edit products / category
        can :manage, [Product, Category, ActsAsTaggableOn::Tag]
        cannot :destroy, [Product, Category]
      else
        # can view and create products / category
        can [:read, :create], [Product, Category, ActsAsTaggableOn::Tag]
      end
    else  
      # not logged in - can only view products / categories
      can :read, [Product, Category]
    end
  end
end
