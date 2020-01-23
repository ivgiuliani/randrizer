# Randrizer

Randrizer is a small library that allows consumers to generate random data
for testing.

```ruby
irb(main):001:0> definition = Randrizer::Types::Dict[{
  Randrizer::Types::Const["hello"] => Randrizer::Types::String[],
  Randrizer::Types::Const["world"] => Randrizer::Types::Int[min: 5, max: 10],
  Randrizer::Types::Const["nested"] => Randrizer::Types::Dict[
    {
      Randrizer::Types::Const["nested1"] => Randrizer::Types::Float[],
      Randrizer::Types::Optional[inner_type: Randrizer::Types::Const["nested2"]] =>
        Randrizer::Types::Int[]
    }
  ]
}]

irb(main):002:0> definition.eval
=> {"hello"=>"XN3#tQd1%5#HWXI*p9zJD!tV^\\e%Wgais]vJQRNp$Z60FymI[=8~xy0IdVrmSb)me59zbqJjTbgZsv1NQA",
 "world"=>6,
 "nested"=>{"nested1"=>2274302953.724733}}
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