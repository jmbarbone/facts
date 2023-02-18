# format.pseudo_id()

    Code
      format(pseudo_id(c(0, 2, 1, 2, 1)))
    Output
      [1] "1 <0>" "2 <2>" "3 <1>" "2 <2>" "3 <1>"

---

    Code
      format(pseudo_id(list(a = 1:2, b = 1:3, c = 1:2)))
    Output
      [1] "1 <1, 2>"    "2 <1, 2, 3>" "1 <1, 2>"   

