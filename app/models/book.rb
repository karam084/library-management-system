class Book < ApplicationRecord
    has_many :bookmarks
    has_many :students, through: :bookmarks
    has_many :checkouts
    has_many :students, through: :checkouts
    has_many :requests
    has_many :students, through: :requests
    has_many :reviews
    has_many :students, through: :reviews
    
    belongs_to :library
  validates :isbn, presence: true
  validates :title, presence: true
  validates :authors, presence: true
  validates :published, presence: true
  validates :edition, presence: true
  validates :language, presence: true
  validates :count, presence: true
  validates_uniqueness_of :isbn, confirmation: { case_sensitive: false }
  
 # mount_uploader :cover, CoverUploader

    def self.search(search)
        if search
            where(["title LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByIsbn(search)
        if search
            where(["isbn LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByAuthor(search)
        if search
            where(["authors LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchBySubject(search)
        if search
            where(["subject LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByCategory(search)
        if search
            where(["category LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByLanguage(search)
        if search
            where(["language LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByPublished(search)
        if search
            where(["published LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByEdition(search)
        if search
            where(["edition LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchBySummary(search)
        if search
            where(["summary LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchBySpecialCollection(search)
        if search
            where(["special_collection LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByLibrary(search)
        if search
            where(["library_id LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByCount(search)
        if search
            where(["count LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByCheckout(search)
        if search
            where(["checkout LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBookmark(search)
        if search
            where(["bookmark LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByRequest(search)
        if search
            where(["request LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByReview(search)
        if search
            where(["review LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByStudent(search)
        if search
            where(["student LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByLibrary(search)
        if search
            where(["library LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByStudent(search)
        if search
            where(["student LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByLibrary(search)
        if search
            where(["library LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByStudent(search)
        if search
            where(["student LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByLibrary(search)
        if search
            where(["library LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByStudent(search)
        if search
            where(["student LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self.searchByBook(search)
        if search
            where(["book LIKE ?","%#{search}%"])
        else
            all
        end
    end

    def self
        if search
            where(["student LIKE ?","%#{search}%"])
        else
            all
        end
    end


end
