# Randrizer

Randrizer is a small library that allows consumers to generate random data
for testing.

```ruby
definition = {
  "this is" => "a constant",
  "but this should be a random positive number" => Randrizer::Types::Int[min: 1, max: 10],
  "and we support nested objects" => {
    "which can also be nested" => [
      Randrizer::Types::String[min_length: 3, max_length: 4, valid_chars: "ABC"],
      Randrizer::Types::Int[min: 0, max: 1000],
      Randrizer::Types::OneOf.build("choice 1", "choice 2", "choice 3")
    ]
  }
}

Randrizer::Generator.generate(definition)
```
```ruby
=> {"this is"=>"a constant",
 "but this should be a random positive number"=>7,
 "and we support nested objects"=>{"which can also be nested"=>["BBB", 828, "choice 2"]}}
```

## Use cases

* Fuzzy testing: create massive amounts of random data for your application
  to consume. Are the inputs sanitised correctly? Are invalid inputs accepted?
* Performance testing: generate random data to be fed to your application to
  measure throughput and performance
* Anonymisation: replace your production data with random values 

## Drivers

Currently there's a single driver out of the box for simple JSON schema files.

```json
$ cat json_schema.json
{
  "$schema": "http://json-schema.org/draft-06/schema#",
  "properties": {
    "resource": {
      "description": "A type",
      "type": "string",
      "enum": ["type 1", "type 2"]
    },
    "amount": {
      "description": "Amount in cents",
      "type": "integer",
      "minimum": 0
    },
    "the_date": {
      "description": "Birthday",
      "type": "string",
      "format": "date"
    },
    "country": {
      "description": "Country code",
      "type": "string",
      "minLength": 2,
      "maxLength": 2
    }
  },
  "type": "object",
  "required": [
    "resource",
    "amount",
    "the_date",
    "country"
  ]
}
```

```json
$ randrizer-json-schema json_schema.json
{
  "resource": "type 1",
  "amount": 302365828,
  "the_date": "2157-09-13",
  "country": "g-"
}
```