package main

import (
	"net/http"
	"os"

	"github.com/sethvargo/go-password/password"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "3200"
	}

	mux := http.NewServeMux()

	mux.HandleFunc("/", indexHandler)
	http.ListenAndServe(":"+port, mux)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {

	w.Write([]byte(gen_password() + "\n"))
}

func gen_password() string {
	res, err := password.Generate(32, 10, 0, false, false)
	if err != nil {
		panic(err)
	}
	return res
}
