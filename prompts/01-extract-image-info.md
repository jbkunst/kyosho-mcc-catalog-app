Analyze the image and return the data strictly in the structure below. The image filename may include hints (brand, scale, variant, etc.). Use filename hints only if they clearly apply; otherwise ignore them.

# Rules

- Return only JSON with the exact field names shown below (no extra text).
- If a field cannot be determined, set it to an empty string "".
- For categorical fields (e.g., body_type, drive_type, engine_position), prefer the suggested values (examples in parentheses) but do not force them—use a different value if it is clearly more accurate.
- Provide a single best-estimate value for each field (no ranges).
- Use metric/ISO units as indicated; values must be plain numbers (no unit strings).
- Get the colors information from the image.

# Structure (simplified)

- manufacturer: Company that builds/assembles the car (examples: BMW, Toyota, Magna Steyr)
- brand: Commercial brand under which the car is sold (examples: Mini, Lexus, Mercedes-Benz)
- model_family: Base line grouping variants
- model: Base model name
- variant_version: Version or trim differentiator (examples: GTE, LM, Competizione, EVO)
- model_code: Internal code or generation (examples: E30, R35, Tipo F120A)
- production_year: Integer (YYYY)
- country_origin: (examples: Italy, Japan, Germany, UK, USA, France)
- engine_type: (examples: Combustion, Hybrid, Electric)
- engine_position: (examples: Front, Mid-front, Mid-rear, Rear)
- cylinder_layout: (examples: V, Boxer, Inline, W, Rotary)
- cylinders_count: Integer number of cylinders (examples: 3, 4, 6, 8, 10, 12, 16)
- displacement_cc: Integer (cc)
- power_hp: Integer
- torque_nm: Integer
- top_speed_kmh: Integer
- drive_type: (examples: RWD, FWD, AWD, 4x4)
- transmission_type: (examples: Manual, Automatic, CVT, Dual-clutch)
- induction: (examples: NA, Turbo, Supercharged, Hybrid ICE+EV)
- length_mm: Integer
- width_mm: Integer
- height_mm: Integer
- wheelbase_mm: Integer
- weight_kg: Integer
- body_type: (examples: Coupe, Sedan, Hatchback, Convertible, Roadster, SUV, Pickup, Wagon, Targa)
- doors_count: (examples: 2, 3, 4, 5)
- main_color: (examples: Red, Blue, White, Black, Yellow, Silver, Green)
- special_finishes: (examples: Pearlescent, Stripes, Matte, Racing Livery, Limited Paint)
- notes: Any other remarks, can be some historical data, why the car was relevant in its time for example, or what races wins.

Miniature info, 
- scale: (examples: 1/18, 1/24, 1/43, 1/64, 1/72) probably will be 1/64 
- miniature_manufacturer: (examples: Kyosho, Aoshima, Konami, Mini GT, Autoart, Minichamps, Tomica)
- reference_number: Manufacturer’s reference/catalog number
- miniature_series: Series or collection name
- release_year: Integer (YYYY)
- packaging_type: (examples: Box, Blister, Loose, Display Case)
- miniature_color: (examples: Red, Blue, White, Black, Silver, Multi-color) Get this information from the image
- miniature_materials: (examples: Diecast, Plastic, Resin, Diecast + Plastic parts)
- miniature_condition: (examples: New, Used, Mint in Box, Loose)

As your response only return the json under this structure.

```json
{
  "manufacturer": "",
  "brand": "",
  "model_family": "",
  "model": "",
  "variant_version": "",
  "model_code": "",
  "production_year": "",
  "country_origin": "",
  "engine_type": "",
  "engine_position": "",
  "cylinder_layout": "",
  "cylinders_count": "",
  "displacement_cc": "",
  "power_hp": "",
  "torque_nm": "",
  "top_speed_kmh": "",
  "drive_type": "",
  "transmission_type": "",
  "induction": "",
  "length_mm": "",
  "width_mm": "",
  "height_mm": "",
  "wheelbase_mm": "",
  "weight_kg": "",
  "body_type": "",
  "doors_count": "",
  "main_color": "",
  "special_finishes": "",
  "notes": "",
  "scale": "",
  "miniature_manufacturer": "",
  "reference_number": "",
  "miniature_series": "",
  "release_year": "",
  "packaging_type": "",
  "miniature_color": "",
  "miniature_materials": "",
  "miniature_condition": ""
}
```

Then you can use the tool `save_json` sending the json and the name of the image to save the informacion to the disk.