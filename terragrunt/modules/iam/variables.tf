variable "iam_user" {
  type = object({
    name = string
  })
}

variable "iam_policy" {
  type = object({
    name        = string
    description = string
    policy      = string // JSON 형식의 IAM 정책 문자열
  })
}
