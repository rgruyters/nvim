return {
  'David-Kunz/gen.nvim',
  opts = {
    model = 'mistral',
  },
  config = function(_, opts)
    local gen = require('gen')
    gen.setup(opts)
    gen.prompts['Work_With_Me'] = {
      prompt = 'You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: Terraform, AWS, kubernetes, python. You answer with code examples when possible. $input:\n$text',
      replace = true,
    }
  end,
}
