package store

type User struct {
	// UUID
	UserID string `json:"id"`
	Role   string `json:"role"`
	Email  string `json:"email"`
	Hash   string `json:"hash"`
}

func NewUser(id, role, email, hash string) *User {
	return &User{
		id, role, email, hash,
	}
}

type Users struct {
	Users []User `json:"users"`
}

type Storer interface {
	ListUsers() (*Users, error)
	GetUserByID(id string) (*User, error)
	GetUserByRole(role string) (*User, error)
}
