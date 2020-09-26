# Data

We need to do DB migrations, Test data and Boostrap data in a unified way. Everyone does bu they dont :)

We use badgerdb and genji.

Good basis i think.
https://github.com/amacneil/dbmate

Later we will add change feed to the DB.
Later we will need to upgrade many DB's in unison.

The DB is embedded in a normal golang project or if you want you can just run it on its own, and call it over grpc. Later will be needed when we split each mod into GRPC and DATA layers, which is natural for scaling and Perf later.

SO you can do DB migrations using the sys CLI.
So the DB URL gets all the GRPC security and other things for free.
The same applies if the dB is embedded. It’s just GRPC after all.

We store the version time stamp in all the dB instances and so we can upgrade many DB's in unison using GRPC streaming. 

We don’t have the migrations in plain files. They are golang files and so get compiled into the code.
The constants are per migration - they HAVE TO BE. So the migrations are strongly typed. Much more secure and if compile fails then maybe it’s your migration code. This is what you want imho.
Constants must be hand coded, and not via Reflection. Just take a copy from the previous migration and change it as needed. YOu can see the change over time by looking in each folder - yes use a Folder with a timestamp name for each migration, its ordered and cleared and contained.
- What are the constants ? 
- DB Table
- DB index, field and types


So yeah it’s a pretty different approach.

Also there is the CLI and web GUI because all that is generated at compile time easily off the GRPC and the migrations are viewable by just reflecting off the code at runtime because the migrations are in golang :)
So Ops Team don’t have go say a pray before running a migration.

DB can be put into auto migrate or checked migrate state. In checked when a migration (due to CD deployment) is needed the ops team gets a notification and url to the web GUI. Also this is a natural fit for audit logging into the DB of the migrations, so that in CLI and GUI you can see what happened. Its just an event being recorded "

The same applies to test and bootstrap data. It’s all golang.
It’s part of each migration too of course because schema and test data must match.

SO the migrations are the key.
So now the golang struct Model is per migration. Reminds me of GRPC ? Field that can be ignored if not needed.
SO why dont we make our DAO models using Protobufs ? Perfect match for Genji because each Table knows nothing about other tables. Its tight. 
We load tons of test Data in.

So now go tests are Unified with migrations.