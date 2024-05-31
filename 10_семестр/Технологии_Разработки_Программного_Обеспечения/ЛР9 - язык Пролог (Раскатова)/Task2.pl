/* Что от чего наследуется: */

connect(edible, object).			/* (съедобный, объект) */
connect(inedible, object).			/* (несъедобный, объект) */

connect(food, edible).				/* (еда, съедобный) */
connect(beverage, edible).			/* (напиток, съедобный) */
connect(equipment, inedible).		/* (снаряжение, несъедобный) */
 
connect(raw, food).					/* (сырая, еда) */
connect(meal, food).				/* (блюдо, еда) */
connect(non_alcoholic, beverage).	/* (безалкогольное, напиток) */
connect(alcohol, beverage).			/* (алкоголь, напиток) */
connect(potion, beverage).			/* (зелье, напиток) */
connect(armor, equipment).			/* (броня, снаряжение) */
connect(weapon, equipment).			/* (оружие, снаряжение) */

connect(berry, raw).				/* (ягода , сырая) */
connect(meat, raw).					/* (мясо , сырая) */
connect(mushroom, raw).				/* (гриб , сырая) */
connect(steak, meal).				/* (стейк , блюдо) */
connect(pie, meal).					/* (пирог , блюдо) */
connect(soup, meal).				/* (суп , блюдо) */
connect(bread, meal).				/* (хлеб , блюдо) */
connect(water, non_alcoholic).		/* (вода, безалкогольное) */
connect(milk, non_alcoholic).		/* (молоко, безалкогольное) */
connect(juice, non_alcoholic).		/* (сок, безалкогольное) */
connect(beer, alcohol).				/* (пиво, алкоголь) */
connect(wine, alcohol).				/* (вино, алкоголь) */
connect(brandy, alcohol).			/* (бренди, алкоголь) */
connect(whiskey, alcohol).			/* (виски, алкоголь) */
connect(vodka, alcohol).			/* (водка, алкоголь) */
connect(strength, potion).			/* (сила, зелье) */
connect(speed, potion).				/* (скорость, зелье) */
connect(agility, potion).			/* (ловкость, зелье) */
connect(stamina, potion).			/* (выносливость, зелье) */
connect(health, potion).			/* (здоровье, зелье) */
connect(manna, potion).				/* (манна, зелье) */
connect(heavy, armor).				/* (тяжелая, броня) */
connect(light, armor).				/* (легкая, броня) */
connect(melee, weapon).				/* (ближнего боя, оружие) */
connect(ranged, weapon).			/* (дальнего боя, оружие) */
 
connect(steel, heavy).				/* (стальная, тяжелая) */
connect(hauberk, light).			/* (кольчуга, легкая) */
connect(leathern, light).			/* (кожаная, легкая) */
connect(short, melee).				/* (короткое, ближнего боя) */
connect(long, melee).				/* (длинное, ближнего боя) */
connect(bow, ranged).				/* (лук, дальнего боя) */
connect(crossbow, ranged).			/* (арбалет, дальнего боя) */

connect(dagger, short).				/* (кинжал, короткое) */
connect(knife, short).				/* (нож, короткое) */
connect(one_handed, long).			/* (одноручное , длинное) */
connect(two_handed, long).			/* (двуручное , длинное) */

connect(broadsword, one_handed).	/* (тесак, одноручное) */
connect(hatchet, one_handed).		/* (топорик, одноручное) */
connect(baton, one_handed).			/* (дубинка, одноручное) */
connect(saber, one_handed).			/* (сабля, одноручное) */
connect(sword, one_handed).			/* (меч, одноручное) */
connect(peak, two_handed).			/* (пика, двуручное) */
connect(battle_axe, two_handed).		/* (секира, двуручное) */
connect(scythe, two_handed).		/* (коса, двуручное) */
connect(halberd, two_handed).		/* (алебарда, двуручное) */

/* Свойства: */
property(object, drop).				/* (предмет, выбросить) */
property(object, sell).				/* (предмет, продать) */
property(object, give).				/* (предмет, отдать) */

property(edible, eat).				/* (съедобный, есть) */

property(beverage, drink).			/* (напиток, выпить) */
property(equipment, equip).			/* (снаряжение, экипировать) */
property(equipment, repair).		/* (снаряжение, чинить) */

property(raw, cook ).				/* (сырая, приготовить) */
property(armor, protect).			/* (броня, защищать) */
property(weapon, attack).			/* (оружие, атаковать) */
property(heavy, reliable).			/* (тяжелая, надежная) */
property(light, comfortable).		/* (легкая, комфортная) */

property(ranged, shoot).			/* (дальнего боя, стрелять) */

property(short, comfortable).		/* (короткое, удобный) */
property(long, powerful).			/* (длинное, мощный) */
property(crossbow, reload).			/* (арбалет, перезарядить) */

property(dagger, cutting).			/* (кинжал, резать) */
property(dagger, stabbing).			/* (кинжал, колоть) */
property(knife, cutting).			/* (нож, резать) */
property(knife, stabbing).			/* (нож, колоть) */
property(broadsword, cutting).		/* (тесак, резать) */
property(broadsword, chopping).		/* (тесак, рубить) */
property(hatchet, chopping).		/* (топорик, рубить) */
property(baton, hitting).			/* (дубинка, бить) */
property(saber, cutting).			/* (сабля, резать) */
property(sword, cutting).			/* (меч, резать) */
property(sword, stabbing).			/* (меч, колоть) */
property(sword, chopping).			/* (меч, рубить) */
property(peak, stabbing).			/* (пика, колоть) */
property(battle_axe, chopping).		/* (секира, рубить) */
property(scythe, cutting).			/* (коса, резать) */
property(halberd, chopping).		/* (алебарда, рубить) */

/* Наследование */
inherit(X, Z) :-					/* X наследует свойство Z, если: */
	connect(X, Y),					/* X соединен с Y */
	property_too(Y, Z).				/* и этот Y обладает темже свойством Z*/
	
property_too(X, Z) :-				/* X также обладает свойством Z, если: */
	property(X, Z);					/* X обладает свойством Z */
	inherit(X, Z). 					/* или X наследует свойство Z */

descendant(X, Y) :-					/* X потомок для Y, если: */
	connect(X, Y).					/* X связан с Y */
descendant(X, Y) :-					/* X потомок для Y, если: */
	connect(X, Z),					/* X связан с Z */
	descendant(Z, Y). 				/* и этот Z потомок для Y */

check_property(X, Z) :-
	property_too(X, Z).
	
properties(X, Properties) :-
	findall(Property, check_property(X, Property), Properties).
 
descendants(Y, Descendants) :-
	findall(Descendant, descendant(Descendant, Y), Descendants).
	
/* Примеры использования:
	?- check_property(saber, eat).			false
	?- check_property(wine, drink).			true
	?- check_property(steel, repair).		true
	?- check_property(bow, drop).			true
	?- check_property(axe, cutting).		false

	?- properties(saber, Properties).		Properties = [cutting, powerful, attack, equip, repair, drop, sell, give].

	?- descendants(armor, Descendants).		Descendants = [heavy, light, steel, hauberk, leathern].
	?- descendants(bread, Descendants).		Descendants = [].
	?- descendants(peak, Descendants). 		Descendants = [].
*/