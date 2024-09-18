const Map<String, String> paper = {
  "Example Items": "printer paper, newspapers, magazines, junk mail, envelopes",
  "Sort Paper Types":
      "Separate recyclable paper from non-recyclable paper. Recyclable paper includes printer paper, newspapers, and magazines. Avoid recycling paper contaminated with food, grease, or heavy ink.",
  "Remove Staples and Clips":
      "Take out any metal clips or staples, though small amounts may be acceptable as they are removed during processing.",
  "Flatten and Bundle":
      "If you have a large amount of paper, flatten it and bundle it together to save space in your recycling bin.",
  "Dry and Clean":
      "Ensure that the paper is dry and clean before placing it in the recycling bin."
};

const Map<String, String> cardboard = {
  "Example Items":
      "shipping boxes, cereal boxes, shoeboxes, paper towel rolls, egg cartons",
  "Flatten Boxes":
      "Break down all cardboard boxes to save space and make handling easier. Remove any plastic tape or labels if possible.",
  "Avoid Contaminated Cardboard":
      "Do not recycle cardboard that has food residues, such as greasy pizza boxes. These should go into the compost bin if possible.",
  "Separate Mixed Materials":
      "Remove any non-cardboard packaging materials like plastic and foam inserts before recycling."
};

const Map<String, String> glass = {
  "Example Items":
      "glass bottles, jars, perfume bottles, light bulbs, condiment bottles",
  "Rinse Thoroughly":
      "Clean glass bottles and jars to remove any food or liquid residue.",
  "Separate by Color":
      "Some recycling programs require you to sort glass by color, as this helps with processing.",
  "Check for Coatings":
      "Avoid recycling glass with coatings or mixed materials, such as mirrors or glass cookware, as these are often not accepted."
};

const Map<String, String> plastic = {
  "Example Items":
      "water bottles, soda bottles, detergent jugs, yogurt cups, food containers",
  "Identify Recyclable Plastics":
      "Check the recycling symbol and number on the bottom of the plastic item. Most programs accept types #1, #2, and sometimes #5.",
  "Clean and Dry":
      "Rinse plastic containers to remove any food or liquid residue, and ensure they are dry before recycling.",
  "Remove Caps and Lids":
      "Remove any plastic caps or lids as they are often made of different materials and may need to be recycled separately."
};

const Map<String, String> metal = {
  "Example Items":
      "aluminum cans, tin cans, steel food cans, aluminum foil, metal lids",
  "Rinse Cans and Containers":
      "Clean metal cans and containers to remove food residue. This includes soda cans, tin cans, and aluminum containers.",
  "No Need to Crush":
      "You do not need to crush cans or metal containers unless space is an issue.",
  "Separate Different Metals":
      "Do not mix different types of metals in one recycling bin; keep them separate if required by your local recycling facility."
};

const Map<String, String> biodegradable = {
  "Example Items":
      "food scraps, coffee grounds, tea bags, yard waste, paper towels",
  "Composting":
      "Biodegradable items can be composted to create nutrient-rich soil. Use a compost bin or pile to break down these materials naturally.",
  "Avoid Contaminants":
      "Do not include non-biodegradable items like plastic, metal, or glass in your compost. These can contaminate the compost and hinder the decomposition process.",
  "Proper Balance":
      "Maintain a proper balance of green (nitrogen-rich) and brown (carbon-rich) materials in your compost. Green materials include food scraps and yard waste, while brown materials include paper towels and dry leaves.",
  "Aeration":
      "Turn your compost regularly to provide aeration, which helps speed up the decomposition process. This also prevents the compost from becoming too compacted.",
  "Moisture Control":
      "Keep your compost moist but not too wet. The ideal moisture level is similar to a damp sponge. Too much moisture can lead to odor problems and slow down decomposition."
};

const Map<String, Map<String, String>> WASTE_ITEM_INFO = {
  "PAPER": paper,
  "CARDBOARD": cardboard,
  "GLASS": glass,
  "PLASTIC": plastic,
  "METAL": metal,
  "BIODEGRADABLE": biodegradable,
};
