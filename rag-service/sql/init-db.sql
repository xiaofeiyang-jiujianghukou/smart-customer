/*
 Navicat Premium Dump SQL

 Source Server         : postgres
 Source Server Type    : PostgreSQL
 Source Server Version : 170009 (170009)
 Source Host           : 127.0.0.1:5432
 Source Catalog        : postgres
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 170009 (170009)
 File Encoding         : 65001

 Date: 10/04/2026 00:20:48
*/


-- ----------------------------
-- Type structure for ghstore
-- ----------------------------
DROP TYPE IF EXISTS "public"."ghstore";
CREATE TYPE "public"."ghstore" (
  INPUT = "public"."ghstore_in",
  OUTPUT = "public"."ghstore_out",
  INTERNALLENGTH = VARIABLE,
  CATEGORY = U,
  DELIMITER = ','
);
ALTER TYPE "public"."ghstore" OWNER TO "postgres";

-- ----------------------------
-- Type structure for halfvec
-- ----------------------------
DROP TYPE IF EXISTS "public"."halfvec";
CREATE TYPE "public"."halfvec" (
  INPUT = "public"."halfvec_in",
  OUTPUT = "public"."halfvec_out",
  RECEIVE = "public"."halfvec_recv",
  SEND = "public"."halfvec_send",
  TYPMOD_IN = "public"."halfvec_typmod_in",
  INTERNALLENGTH = VARIABLE,
  STORAGE = external,
  CATEGORY = U,
  DELIMITER = ','
);
ALTER TYPE "public"."halfvec" OWNER TO "postgres";

-- ----------------------------
-- Type structure for hstore
-- ----------------------------
DROP TYPE IF EXISTS "public"."hstore";
CREATE TYPE "public"."hstore" (
  INPUT = "public"."hstore_in",
  OUTPUT = "public"."hstore_out",
  RECEIVE = "public"."hstore_recv",
  SEND = "public"."hstore_send",
  INTERNALLENGTH = VARIABLE,
  STORAGE = extended,
  CATEGORY = U,
  DELIMITER = ','
);
ALTER TYPE "public"."hstore" OWNER TO "postgres";

-- ----------------------------
-- Type structure for rum_distance_query
-- ----------------------------
DROP TYPE IF EXISTS "public"."rum_distance_query";
CREATE TYPE "public"."rum_distance_query" AS (
  "query" tsquery,
  "method" int4
);
ALTER TYPE "public"."rum_distance_query" OWNER TO "postgres";

-- ----------------------------
-- Type structure for sparsevec
-- ----------------------------
DROP TYPE IF EXISTS "public"."sparsevec";
CREATE TYPE "public"."sparsevec" (
  INPUT = "public"."sparsevec_in",
  OUTPUT = "public"."sparsevec_out",
  RECEIVE = "public"."sparsevec_recv",
  SEND = "public"."sparsevec_send",
  TYPMOD_IN = "public"."sparsevec_typmod_in",
  INTERNALLENGTH = VARIABLE,
  STORAGE = external,
  CATEGORY = U,
  DELIMITER = ','
);
ALTER TYPE "public"."sparsevec" OWNER TO "postgres";

-- ----------------------------
-- Type structure for vector
-- ----------------------------
DROP TYPE IF EXISTS "public"."vector";
CREATE TYPE "public"."vector" (
  INPUT = "public"."vector_in",
  OUTPUT = "public"."vector_out",
  RECEIVE = "public"."vector_recv",
  SEND = "public"."vector_send",
  TYPMOD_IN = "public"."vector_typmod_in",
  INTERNALLENGTH = VARIABLE,
  STORAGE = external,
  CATEGORY = U,
  DELIMITER = ','
);
ALTER TYPE "public"."vector" OWNER TO "postgres";

-- ----------------------------
-- Table structure for vector_store
-- ----------------------------
DROP TABLE IF EXISTS "public"."vector_store";
CREATE TABLE "public"."vector_store" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "content" text COLLATE "pg_catalog"."default",
  "metadata" json,
  "embedding" vector(1024)
)
;
ALTER TABLE "public"."vector_store" OWNER TO "postgres";

-- ----------------------------
-- Function structure for akeys
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."akeys"("public"."hstore");
CREATE FUNCTION "public"."akeys"("public"."hstore")
  RETURNS "pg_catalog"."_text" AS '$libdir/hstore', 'hstore_akeys'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."akeys"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_halfvec"(_float4, int4, bool);
CREATE FUNCTION "public"."array_to_halfvec"(_float4, int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'array_to_halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_halfvec"(_float4, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_halfvec"(_int4, int4, bool);
CREATE FUNCTION "public"."array_to_halfvec"(_int4, int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'array_to_halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_halfvec"(_int4, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_halfvec"(_numeric, int4, bool);
CREATE FUNCTION "public"."array_to_halfvec"(_numeric, int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'array_to_halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_halfvec"(_numeric, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_halfvec"(_float8, int4, bool);
CREATE FUNCTION "public"."array_to_halfvec"(_float8, int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'array_to_halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_halfvec"(_float8, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_sparsevec"(_float4, int4, bool);
CREATE FUNCTION "public"."array_to_sparsevec"(_float4, int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'array_to_sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_sparsevec"(_float4, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_sparsevec"(_float8, int4, bool);
CREATE FUNCTION "public"."array_to_sparsevec"(_float8, int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'array_to_sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_sparsevec"(_float8, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_sparsevec"(_numeric, int4, bool);
CREATE FUNCTION "public"."array_to_sparsevec"(_numeric, int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'array_to_sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_sparsevec"(_numeric, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_sparsevec"(_int4, int4, bool);
CREATE FUNCTION "public"."array_to_sparsevec"(_int4, int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'array_to_sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_sparsevec"(_int4, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_vector"(_float4, int4, bool);
CREATE FUNCTION "public"."array_to_vector"(_float4, int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'array_to_vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_vector"(_float4, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_vector"(_numeric, int4, bool);
CREATE FUNCTION "public"."array_to_vector"(_numeric, int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'array_to_vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_vector"(_numeric, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_vector"(_float8, int4, bool);
CREATE FUNCTION "public"."array_to_vector"(_float8, int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'array_to_vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_vector"(_float8, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for array_to_vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."array_to_vector"(_int4, int4, bool);
CREATE FUNCTION "public"."array_to_vector"(_int4, int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'array_to_vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."array_to_vector"(_int4, int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for avals
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."avals"("public"."hstore");
CREATE FUNCTION "public"."avals"("public"."hstore")
  RETURNS "pg_catalog"."_text" AS '$libdir/hstore', 'hstore_avals'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."avals"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for binary_quantize
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."binary_quantize"("public"."vector");
CREATE FUNCTION "public"."binary_quantize"("public"."vector")
  RETURNS "pg_catalog"."bit" AS '$libdir/vector', 'binary_quantize'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."binary_quantize"("public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for binary_quantize
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."binary_quantize"("public"."halfvec");
CREATE FUNCTION "public"."binary_quantize"("public"."halfvec")
  RETURNS "pg_catalog"."bit" AS '$libdir/vector', 'halfvec_binary_quantize'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."binary_quantize"("public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for cosine_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."cosine_distance"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."cosine_distance"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'cosine_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."cosine_distance"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for cosine_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."cosine_distance"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."cosine_distance"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_cosine_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."cosine_distance"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for cosine_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."cosine_distance"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."cosine_distance"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_cosine_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."cosine_distance"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for defined
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."defined"("public"."hstore", text);
CREATE FUNCTION "public"."defined"("public"."hstore", text)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_defined'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."defined"("public"."hstore", text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."delete"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."delete"("public"."hstore", "public"."hstore")
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_delete_hstore'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."delete"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."delete"("public"."hstore", text);
CREATE FUNCTION "public"."delete"("public"."hstore", text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_delete'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."delete"("public"."hstore", text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."delete"("public"."hstore", _text);
CREATE FUNCTION "public"."delete"("public"."hstore", _text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_delete_array'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."delete"("public"."hstore", _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for each
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."each"("hs" "public"."hstore", OUT "key" text, OUT "value" text);
CREATE FUNCTION "public"."each"(IN "hs" "public"."hstore", OUT "key" text, OUT "value" text)
  RETURNS SETOF "pg_catalog"."record" AS '$libdir/hstore', 'hstore_each'
  LANGUAGE c IMMUTABLE STRICT
  COST 1
  ROWS 1000;
ALTER FUNCTION "public"."each"("hs" "public"."hstore", OUT "key" text, OUT "value" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for exist
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."exist"("public"."hstore", text);
CREATE FUNCTION "public"."exist"("public"."hstore", text)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_exists'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."exist"("public"."hstore", text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for exists_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."exists_all"("public"."hstore", _text);
CREATE FUNCTION "public"."exists_all"("public"."hstore", _text)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_exists_all'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."exists_all"("public"."hstore", _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for exists_any
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."exists_any"("public"."hstore", _text);
CREATE FUNCTION "public"."exists_any"("public"."hstore", _text)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_exists_any'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."exists_any"("public"."hstore", _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for fetchval
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."fetchval"("public"."hstore", text);
CREATE FUNCTION "public"."fetchval"("public"."hstore", text)
  RETURNS "pg_catalog"."text" AS '$libdir/hstore', 'hstore_fetchval'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."fetchval"("public"."hstore", text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_compress
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_compress"(internal);
CREATE FUNCTION "public"."ghstore_compress"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'ghstore_compress'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_compress"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_consistent"(internal, "public"."hstore", int2, oid, internal);
CREATE FUNCTION "public"."ghstore_consistent"(internal, "public"."hstore", int2, oid, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'ghstore_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_consistent"(internal, "public"."hstore", int2, oid, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_decompress
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_decompress"(internal);
CREATE FUNCTION "public"."ghstore_decompress"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'ghstore_decompress'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_decompress"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_in"(cstring);
CREATE FUNCTION "public"."ghstore_in"(cstring)
  RETURNS "public"."ghstore" AS '$libdir/hstore', 'ghstore_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_in"(cstring) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_options
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_options"(internal);
CREATE FUNCTION "public"."ghstore_options"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/hstore', 'ghstore_options'
  LANGUAGE c IMMUTABLE
  COST 1;
ALTER FUNCTION "public"."ghstore_options"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_out
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_out"("public"."ghstore");
CREATE FUNCTION "public"."ghstore_out"("public"."ghstore")
  RETURNS "pg_catalog"."cstring" AS '$libdir/hstore', 'ghstore_out'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_out"("public"."ghstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_penalty
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_penalty"(internal, internal, internal);
CREATE FUNCTION "public"."ghstore_penalty"(internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'ghstore_penalty'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_penalty"(internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_picksplit
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_picksplit"(internal, internal);
CREATE FUNCTION "public"."ghstore_picksplit"(internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'ghstore_picksplit'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_picksplit"(internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_same
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_same"("public"."ghstore", "public"."ghstore", internal);
CREATE FUNCTION "public"."ghstore_same"("public"."ghstore", "public"."ghstore", internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'ghstore_same'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_same"("public"."ghstore", "public"."ghstore", internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ghstore_union
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ghstore_union"(internal, internal);
CREATE FUNCTION "public"."ghstore_union"(internal, internal)
  RETURNS "public"."ghstore" AS '$libdir/hstore', 'ghstore_union'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ghstore_union"(internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for gin_consistent_hstore
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gin_consistent_hstore"(internal, int2, "public"."hstore", int4, internal, internal);
CREATE FUNCTION "public"."gin_consistent_hstore"(internal, int2, "public"."hstore", int4, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'gin_consistent_hstore'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."gin_consistent_hstore"(internal, int2, "public"."hstore", int4, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for gin_extract_hstore
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gin_extract_hstore"("public"."hstore", internal);
CREATE FUNCTION "public"."gin_extract_hstore"("public"."hstore", internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'gin_extract_hstore'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."gin_extract_hstore"("public"."hstore", internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for gin_extract_hstore_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gin_extract_hstore_query"("public"."hstore", internal, int2, internal, internal);
CREATE FUNCTION "public"."gin_extract_hstore_query"("public"."hstore", internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'gin_extract_hstore_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."gin_extract_hstore_query"("public"."hstore", internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec"("public"."halfvec", int4, bool);
CREATE FUNCTION "public"."halfvec"("public"."halfvec", int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec"("public"."halfvec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_accum
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_accum"(_float8, "public"."halfvec");
CREATE FUNCTION "public"."halfvec_accum"(_float8, "public"."halfvec")
  RETURNS "pg_catalog"."_float8" AS '$libdir/vector', 'halfvec_accum'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_accum"(_float8, "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_add"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_add"("public"."halfvec", "public"."halfvec")
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_add'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_add"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_avg
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_avg"(_float8);
CREATE FUNCTION "public"."halfvec_avg"(_float8)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_avg'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_avg"(_float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_cmp"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_cmp"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'halfvec_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_cmp"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_combine
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_combine"(_float8, _float8);
CREATE FUNCTION "public"."halfvec_combine"(_float8, _float8)
  RETURNS "pg_catalog"."_float8" AS '$libdir/vector', 'vector_combine'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_combine"(_float8, _float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_concat
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_concat"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_concat"("public"."halfvec", "public"."halfvec")
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_concat'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_concat"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_eq
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_eq"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_eq"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'halfvec_eq'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_eq"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_ge
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_ge"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_ge"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'halfvec_ge'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_ge"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_gt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_gt"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_gt"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'halfvec_gt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_gt"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_in"(cstring, oid, int4);
CREATE FUNCTION "public"."halfvec_in"(cstring, oid, int4)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_in"(cstring, oid, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_l2_squared_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_l2_squared_distance"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_l2_squared_distance"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_l2_squared_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_l2_squared_distance"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_le
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_le"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_le"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'halfvec_le'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_le"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_lt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_lt"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_lt"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'halfvec_lt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_lt"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_mul
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_mul"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_mul"("public"."halfvec", "public"."halfvec")
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_mul'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_mul"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_ne
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_ne"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_ne"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'halfvec_ne'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_ne"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_negative_inner_product
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_negative_inner_product"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_negative_inner_product"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_negative_inner_product'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_negative_inner_product"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_out
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_out"("public"."halfvec");
CREATE FUNCTION "public"."halfvec_out"("public"."halfvec")
  RETURNS "pg_catalog"."cstring" AS '$libdir/vector', 'halfvec_out'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_out"("public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_recv
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_recv"(internal, oid, int4);
CREATE FUNCTION "public"."halfvec_recv"(internal, oid, int4)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_recv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_recv"(internal, oid, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_send
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_send"("public"."halfvec");
CREATE FUNCTION "public"."halfvec_send"("public"."halfvec")
  RETURNS "pg_catalog"."bytea" AS '$libdir/vector', 'halfvec_send'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_send"("public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_spherical_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_spherical_distance"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_spherical_distance"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_spherical_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_spherical_distance"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_sub
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_sub"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."halfvec_sub"("public"."halfvec", "public"."halfvec")
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_sub'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_sub"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_to_float4
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_to_float4"("public"."halfvec", int4, bool);
CREATE FUNCTION "public"."halfvec_to_float4"("public"."halfvec", int4, bool)
  RETURNS "pg_catalog"."_float4" AS '$libdir/vector', 'halfvec_to_float4'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_to_float4"("public"."halfvec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_to_sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_to_sparsevec"("public"."halfvec", int4, bool);
CREATE FUNCTION "public"."halfvec_to_sparsevec"("public"."halfvec", int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'halfvec_to_sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_to_sparsevec"("public"."halfvec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_to_vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_to_vector"("public"."halfvec", int4, bool);
CREATE FUNCTION "public"."halfvec_to_vector"("public"."halfvec", int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'halfvec_to_vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_to_vector"("public"."halfvec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for halfvec_typmod_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."halfvec_typmod_in"(_cstring);
CREATE FUNCTION "public"."halfvec_typmod_in"(_cstring)
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'halfvec_typmod_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."halfvec_typmod_in"(_cstring) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hamming_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hamming_distance"(bit, bit);
CREATE FUNCTION "public"."hamming_distance"(bit, bit)
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'hamming_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hamming_distance"(bit, bit) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hnsw_bit_support
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hnsw_bit_support"(internal);
CREATE FUNCTION "public"."hnsw_bit_support"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/vector', 'hnsw_bit_support'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."hnsw_bit_support"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hnsw_halfvec_support
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hnsw_halfvec_support"(internal);
CREATE FUNCTION "public"."hnsw_halfvec_support"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/vector', 'hnsw_halfvec_support'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."hnsw_halfvec_support"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hnsw_sparsevec_support
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hnsw_sparsevec_support"(internal);
CREATE FUNCTION "public"."hnsw_sparsevec_support"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/vector', 'hnsw_sparsevec_support'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."hnsw_sparsevec_support"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hnswhandler
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hnswhandler"(internal);
CREATE FUNCTION "public"."hnswhandler"(internal)
  RETURNS "pg_catalog"."index_am_handler" AS '$libdir/vector', 'hnswhandler'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."hnswhandler"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hs_concat
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hs_concat"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hs_concat"("public"."hstore", "public"."hstore")
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_concat'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hs_concat"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hs_contained
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hs_contained"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hs_contained"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_contained'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hs_contained"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hs_contains
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hs_contains"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hs_contains"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_contains'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hs_contains"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore"(record);
CREATE FUNCTION "public"."hstore"(record)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_from_record'
  LANGUAGE c IMMUTABLE
  COST 1;
ALTER FUNCTION "public"."hstore"(record) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore"(_text);
CREATE FUNCTION "public"."hstore"(_text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_from_array'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore"(_text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore"(_text, _text);
CREATE FUNCTION "public"."hstore"(_text, _text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_from_arrays'
  LANGUAGE c IMMUTABLE
  COST 1;
ALTER FUNCTION "public"."hstore"(_text, _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore"(text, text);
CREATE FUNCTION "public"."hstore"(text, text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_from_text'
  LANGUAGE c IMMUTABLE
  COST 1;
ALTER FUNCTION "public"."hstore"(text, text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_cmp"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_cmp"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."int4" AS '$libdir/hstore', 'hstore_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_cmp"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_eq
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_eq"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_eq"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_eq'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_eq"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_ge
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_ge"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_ge"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_ge'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_ge"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_gt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_gt"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_gt"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_gt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_gt"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_hash
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_hash"("public"."hstore");
CREATE FUNCTION "public"."hstore_hash"("public"."hstore")
  RETURNS "pg_catalog"."int4" AS '$libdir/hstore', 'hstore_hash'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_hash"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_hash_extended
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_hash_extended"("public"."hstore", int8);
CREATE FUNCTION "public"."hstore_hash_extended"("public"."hstore", int8)
  RETURNS "pg_catalog"."int8" AS '$libdir/hstore', 'hstore_hash_extended'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_hash_extended"("public"."hstore", int8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_in"(cstring);
CREATE FUNCTION "public"."hstore_in"(cstring)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_in"(cstring) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_le
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_le"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_le"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_le'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_le"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_lt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_lt"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_lt"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_lt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_lt"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_ne
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_ne"("public"."hstore", "public"."hstore");
CREATE FUNCTION "public"."hstore_ne"("public"."hstore", "public"."hstore")
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_ne'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_ne"("public"."hstore", "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_out
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_out"("public"."hstore");
CREATE FUNCTION "public"."hstore_out"("public"."hstore")
  RETURNS "pg_catalog"."cstring" AS '$libdir/hstore', 'hstore_out'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_out"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_recv
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_recv"(internal);
CREATE FUNCTION "public"."hstore_recv"(internal)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_recv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_recv"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_send
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_send"("public"."hstore");
CREATE FUNCTION "public"."hstore_send"("public"."hstore")
  RETURNS "pg_catalog"."bytea" AS '$libdir/hstore', 'hstore_send'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_send"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_subscript_handler
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_subscript_handler"(internal);
CREATE FUNCTION "public"."hstore_subscript_handler"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/hstore', 'hstore_subscript_handler'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_subscript_handler"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_to_array
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_to_array"("public"."hstore");
CREATE FUNCTION "public"."hstore_to_array"("public"."hstore")
  RETURNS "pg_catalog"."_text" AS '$libdir/hstore', 'hstore_to_array'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_to_array"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_to_json
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_to_json"("public"."hstore");
CREATE FUNCTION "public"."hstore_to_json"("public"."hstore")
  RETURNS "pg_catalog"."json" AS '$libdir/hstore', 'hstore_to_json'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_to_json"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_to_json_loose
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_to_json_loose"("public"."hstore");
CREATE FUNCTION "public"."hstore_to_json_loose"("public"."hstore")
  RETURNS "pg_catalog"."json" AS '$libdir/hstore', 'hstore_to_json_loose'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_to_json_loose"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_to_jsonb
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_to_jsonb"("public"."hstore");
CREATE FUNCTION "public"."hstore_to_jsonb"("public"."hstore")
  RETURNS "pg_catalog"."jsonb" AS '$libdir/hstore', 'hstore_to_jsonb'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_to_jsonb"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_to_jsonb_loose
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_to_jsonb_loose"("public"."hstore");
CREATE FUNCTION "public"."hstore_to_jsonb_loose"("public"."hstore")
  RETURNS "pg_catalog"."jsonb" AS '$libdir/hstore', 'hstore_to_jsonb_loose'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_to_jsonb_loose"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_to_matrix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_to_matrix"("public"."hstore");
CREATE FUNCTION "public"."hstore_to_matrix"("public"."hstore")
  RETURNS "pg_catalog"."_text" AS '$libdir/hstore', 'hstore_to_matrix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_to_matrix"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for hstore_version_diag
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hstore_version_diag"("public"."hstore");
CREATE FUNCTION "public"."hstore_version_diag"("public"."hstore")
  RETURNS "pg_catalog"."int4" AS '$libdir/hstore', 'hstore_version_diag'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."hstore_version_diag"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for inner_product
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."inner_product"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."inner_product"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'inner_product'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."inner_product"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for inner_product
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."inner_product"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."inner_product"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_inner_product'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."inner_product"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for inner_product
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."inner_product"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."inner_product"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_inner_product'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."inner_product"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for isdefined
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."isdefined"("public"."hstore", text);
CREATE FUNCTION "public"."isdefined"("public"."hstore", text)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_defined'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."isdefined"("public"."hstore", text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for isexists
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."isexists"("public"."hstore", text);
CREATE FUNCTION "public"."isexists"("public"."hstore", text)
  RETURNS "pg_catalog"."bool" AS '$libdir/hstore', 'hstore_exists'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."isexists"("public"."hstore", text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ivfflat_bit_support
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ivfflat_bit_support"(internal);
CREATE FUNCTION "public"."ivfflat_bit_support"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/vector', 'ivfflat_bit_support'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."ivfflat_bit_support"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ivfflat_halfvec_support
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ivfflat_halfvec_support"(internal);
CREATE FUNCTION "public"."ivfflat_halfvec_support"(internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/vector', 'ivfflat_halfvec_support'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."ivfflat_halfvec_support"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ivfflathandler
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ivfflathandler"(internal);
CREATE FUNCTION "public"."ivfflathandler"(internal)
  RETURNS "pg_catalog"."index_am_handler" AS '$libdir/vector', 'ivfflathandler'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."ivfflathandler"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for jaccard_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."jaccard_distance"(bit, bit);
CREATE FUNCTION "public"."jaccard_distance"(bit, bit)
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'jaccard_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."jaccard_distance"(bit, bit) OWNER TO "postgres";

-- ----------------------------
-- Function structure for l1_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l1_distance"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."l1_distance"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_l1_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l1_distance"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l1_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l1_distance"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."l1_distance"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'l1_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l1_distance"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l1_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l1_distance"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."l1_distance"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_l1_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l1_distance"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_distance"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."l2_distance"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_l2_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_distance"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_distance"("public"."halfvec", "public"."halfvec");
CREATE FUNCTION "public"."l2_distance"("public"."halfvec", "public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_l2_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_distance"("public"."halfvec", "public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_distance"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."l2_distance"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'l2_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_distance"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_norm
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_norm"("public"."halfvec");
CREATE FUNCTION "public"."l2_norm"("public"."halfvec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'halfvec_l2_norm'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_norm"("public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_norm
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_norm"("public"."sparsevec");
CREATE FUNCTION "public"."l2_norm"("public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_l2_norm'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_norm"("public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_normalize
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_normalize"("public"."halfvec");
CREATE FUNCTION "public"."l2_normalize"("public"."halfvec")
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_l2_normalize'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_normalize"("public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_normalize
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_normalize"("public"."vector");
CREATE FUNCTION "public"."l2_normalize"("public"."vector")
  RETURNS "public"."vector" AS '$libdir/vector', 'l2_normalize'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_normalize"("public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for l2_normalize
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."l2_normalize"("public"."sparsevec");
CREATE FUNCTION "public"."l2_normalize"("public"."sparsevec")
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'sparsevec_l2_normalize'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."l2_normalize"("public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for populate_record
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."populate_record"(anyelement, "public"."hstore");
CREATE FUNCTION "public"."populate_record"(anyelement, "public"."hstore")
  RETURNS "pg_catalog"."anyelement" AS '$libdir/hstore', 'hstore_populate_record'
  LANGUAGE c IMMUTABLE
  COST 1;
ALTER FUNCTION "public"."populate_record"(anyelement, "public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_anyarray_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_anyarray_config"(internal);
CREATE FUNCTION "public"."rum_anyarray_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_anyarray_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_anyarray_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_anyarray_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_anyarray_consistent"(internal, int2, anyarray, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_anyarray_consistent"(internal, int2, anyarray, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_anyarray_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_anyarray_consistent"(internal, int2, anyarray, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_anyarray_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_anyarray_distance"(anyarray, anyarray);
CREATE FUNCTION "public"."rum_anyarray_distance"(anyarray, anyarray)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_anyarray_distance'
  LANGUAGE c STABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_anyarray_distance"(anyarray, anyarray) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_anyarray_ordering
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_anyarray_ordering"(internal, int2, anyarray, int4, internal, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_anyarray_ordering"(internal, int2, anyarray, int4, internal, internal, internal, internal, internal)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_anyarray_ordering'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_anyarray_ordering"(internal, int2, anyarray, int4, internal, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_anyarray_similar
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_anyarray_similar"(anyarray, anyarray);
CREATE FUNCTION "public"."rum_anyarray_similar"(anyarray, anyarray)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_anyarray_similar'
  LANGUAGE c STABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_anyarray_similar"(anyarray, anyarray) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_bit_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_bit_compare_prefix"(bit, bit, int2, internal);
CREATE FUNCTION "public"."rum_bit_compare_prefix"(bit, bit, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_bit_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_bit_compare_prefix"(bit, bit, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_bit_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_bit_extract_query"(bit, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_bit_extract_query"(bit, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_bit_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_bit_extract_query"(bit, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_bit_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_bit_extract_value"(bit, internal);
CREATE FUNCTION "public"."rum_bit_extract_value"(bit, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_bit_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_bit_extract_value"(bit, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_btree_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_btree_consistent"(internal, int2, internal, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_btree_consistent"(internal, int2, internal, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_btree_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_btree_consistent"(internal, int2, internal, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_bytea_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_bytea_compare_prefix"(bytea, bytea, int2, internal);
CREATE FUNCTION "public"."rum_bytea_compare_prefix"(bytea, bytea, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_bytea_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_bytea_compare_prefix"(bytea, bytea, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_bytea_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_bytea_extract_query"(bytea, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_bytea_extract_query"(bytea, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_bytea_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_bytea_extract_query"(bytea, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_bytea_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_bytea_extract_value"(bytea, internal);
CREATE FUNCTION "public"."rum_bytea_extract_value"(bytea, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_bytea_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_bytea_extract_value"(bytea, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_char_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_char_compare_prefix"(char, char, int2, internal);
CREATE FUNCTION "public"."rum_char_compare_prefix"(char, char, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_char_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_char_compare_prefix"(char, char, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_char_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_char_extract_query"(char, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_char_extract_query"(char, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_char_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_char_extract_query"(char, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_char_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_char_extract_value"(char, internal);
CREATE FUNCTION "public"."rum_char_extract_value"(char, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_char_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_char_extract_value"(char, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_cidr_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_cidr_compare_prefix"(cidr, cidr, int2, internal);
CREATE FUNCTION "public"."rum_cidr_compare_prefix"(cidr, cidr, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_cidr_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_cidr_compare_prefix"(cidr, cidr, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_cidr_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_cidr_extract_query"(cidr, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_cidr_extract_query"(cidr, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_cidr_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_cidr_extract_query"(cidr, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_cidr_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_cidr_extract_value"(cidr, internal);
CREATE FUNCTION "public"."rum_cidr_extract_value"(cidr, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_cidr_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_cidr_extract_value"(cidr, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_date_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_date_compare_prefix"(date, date, int2, internal);
CREATE FUNCTION "public"."rum_date_compare_prefix"(date, date, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_date_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_date_compare_prefix"(date, date, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_date_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_date_extract_query"(date, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_date_extract_query"(date, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_date_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_date_extract_query"(date, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_date_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_date_extract_value"(date, internal);
CREATE FUNCTION "public"."rum_date_extract_value"(date, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_date_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_date_extract_value"(date, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_extract_anyarray
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_extract_anyarray"(anyarray, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_extract_anyarray"(anyarray, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_extract_anyarray'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_extract_anyarray"(anyarray, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_extract_anyarray_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_extract_anyarray_query"(anyarray, internal, int2, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_extract_anyarray_query"(anyarray, internal, int2, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_extract_anyarray_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_extract_anyarray_query"(anyarray, internal, int2, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_extract_tsquery
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_extract_tsquery"(tsquery, internal, int2, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_extract_tsquery"(tsquery, internal, int2, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_extract_tsquery'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_extract_tsquery"(tsquery, internal, int2, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_extract_tsquery_hash
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_extract_tsquery_hash"(tsquery, internal, int2, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_extract_tsquery_hash"(tsquery, internal, int2, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_extract_tsquery_hash'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_extract_tsquery_hash"(tsquery, internal, int2, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_extract_tsvector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_extract_tsvector"(tsvector, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_extract_tsvector"(tsvector, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_extract_tsvector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_extract_tsvector"(tsvector, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_extract_tsvector_hash
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_extract_tsvector_hash"(tsvector, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_extract_tsvector_hash"(tsvector, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_extract_tsvector_hash'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_extract_tsvector_hash"(tsvector, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_compare_prefix"(float4, float4, int2, internal);
CREATE FUNCTION "public"."rum_float4_compare_prefix"(float4, float4, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_float4_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_compare_prefix"(float4, float4, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_config"(internal);
CREATE FUNCTION "public"."rum_float4_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_float4_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_distance"(float4, float4);
CREATE FUNCTION "public"."rum_float4_distance"(float4, float4)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float4_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_distance"(float4, float4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_extract_query"(float4, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_float4_extract_query"(float4, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_float4_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_extract_query"(float4, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_extract_value"(float4, internal);
CREATE FUNCTION "public"."rum_float4_extract_value"(float4, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_float4_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_extract_value"(float4, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_key_distance"(float4, float4, int2);
CREATE FUNCTION "public"."rum_float4_key_distance"(float4, float4, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float4_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_key_distance"(float4, float4, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_left_distance"(float4, float4);
CREATE FUNCTION "public"."rum_float4_left_distance"(float4, float4)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float4_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_left_distance"(float4, float4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_outer_distance"(float4, float4, int2);
CREATE FUNCTION "public"."rum_float4_outer_distance"(float4, float4, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float4_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_outer_distance"(float4, float4, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float4_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float4_right_distance"(float4, float4);
CREATE FUNCTION "public"."rum_float4_right_distance"(float4, float4)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float4_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float4_right_distance"(float4, float4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_compare_prefix"(float8, float8, int2, internal);
CREATE FUNCTION "public"."rum_float8_compare_prefix"(float8, float8, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_float8_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_compare_prefix"(float8, float8, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_config"(internal);
CREATE FUNCTION "public"."rum_float8_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_float8_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_distance"(float8, float8);
CREATE FUNCTION "public"."rum_float8_distance"(float8, float8)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float8_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_distance"(float8, float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_extract_query"(float8, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_float8_extract_query"(float8, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_float8_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_extract_query"(float8, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_extract_value"(float8, internal);
CREATE FUNCTION "public"."rum_float8_extract_value"(float8, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_float8_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_extract_value"(float8, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_key_distance"(float8, float8, int2);
CREATE FUNCTION "public"."rum_float8_key_distance"(float8, float8, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float8_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_key_distance"(float8, float8, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_left_distance"(float8, float8);
CREATE FUNCTION "public"."rum_float8_left_distance"(float8, float8)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float8_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_left_distance"(float8, float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_outer_distance"(float8, float8, int2);
CREATE FUNCTION "public"."rum_float8_outer_distance"(float8, float8, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float8_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_outer_distance"(float8, float8, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_float8_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_float8_right_distance"(float8, float8);
CREATE FUNCTION "public"."rum_float8_right_distance"(float8, float8)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_float8_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_float8_right_distance"(float8, float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_inet_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_inet_compare_prefix"(inet, inet, int2, internal);
CREATE FUNCTION "public"."rum_inet_compare_prefix"(inet, inet, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_inet_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_inet_compare_prefix"(inet, inet, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_inet_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_inet_extract_query"(inet, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_inet_extract_query"(inet, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_inet_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_inet_extract_query"(inet, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_inet_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_inet_extract_value"(inet, internal);
CREATE FUNCTION "public"."rum_inet_extract_value"(inet, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_inet_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_inet_extract_value"(inet, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_compare_prefix"(int2, int2, int2, internal);
CREATE FUNCTION "public"."rum_int2_compare_prefix"(int2, int2, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_int2_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_compare_prefix"(int2, int2, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_config"(internal);
CREATE FUNCTION "public"."rum_int2_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_int2_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_distance"(int2, int2);
CREATE FUNCTION "public"."rum_int2_distance"(int2, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int2_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_distance"(int2, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_extract_query"(int2, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_int2_extract_query"(int2, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_int2_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_extract_query"(int2, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_extract_value"(int2, internal);
CREATE FUNCTION "public"."rum_int2_extract_value"(int2, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_int2_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_extract_value"(int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_key_distance"(int2, int2, int2);
CREATE FUNCTION "public"."rum_int2_key_distance"(int2, int2, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int2_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_key_distance"(int2, int2, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_left_distance"(int2, int2);
CREATE FUNCTION "public"."rum_int2_left_distance"(int2, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int2_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_left_distance"(int2, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_outer_distance"(int2, int2, int2);
CREATE FUNCTION "public"."rum_int2_outer_distance"(int2, int2, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int2_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_outer_distance"(int2, int2, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int2_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int2_right_distance"(int2, int2);
CREATE FUNCTION "public"."rum_int2_right_distance"(int2, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int2_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int2_right_distance"(int2, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_compare_prefix"(int4, int4, int2, internal);
CREATE FUNCTION "public"."rum_int4_compare_prefix"(int4, int4, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_int4_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_compare_prefix"(int4, int4, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_config"(internal);
CREATE FUNCTION "public"."rum_int4_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_int4_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_distance"(int4, int4);
CREATE FUNCTION "public"."rum_int4_distance"(int4, int4)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int4_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_distance"(int4, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_extract_query"(int4, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_int4_extract_query"(int4, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_int4_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_extract_query"(int4, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_extract_value"(int4, internal);
CREATE FUNCTION "public"."rum_int4_extract_value"(int4, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_int4_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_extract_value"(int4, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_key_distance"(int4, int4, int2);
CREATE FUNCTION "public"."rum_int4_key_distance"(int4, int4, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int4_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_key_distance"(int4, int4, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_left_distance"(int4, int4);
CREATE FUNCTION "public"."rum_int4_left_distance"(int4, int4)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int4_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_left_distance"(int4, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_outer_distance"(int4, int4, int2);
CREATE FUNCTION "public"."rum_int4_outer_distance"(int4, int4, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int4_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_outer_distance"(int4, int4, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int4_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int4_right_distance"(int4, int4);
CREATE FUNCTION "public"."rum_int4_right_distance"(int4, int4)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int4_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int4_right_distance"(int4, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_compare_prefix"(int8, int8, int2, internal);
CREATE FUNCTION "public"."rum_int8_compare_prefix"(int8, int8, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_int8_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_compare_prefix"(int8, int8, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_config"(internal);
CREATE FUNCTION "public"."rum_int8_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_int8_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_distance"(int8, int8);
CREATE FUNCTION "public"."rum_int8_distance"(int8, int8)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int8_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_distance"(int8, int8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_extract_query"(int8, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_int8_extract_query"(int8, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_int8_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_extract_query"(int8, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_extract_value"(int8, internal);
CREATE FUNCTION "public"."rum_int8_extract_value"(int8, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_int8_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_extract_value"(int8, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_key_distance"(int8, int8, int2);
CREATE FUNCTION "public"."rum_int8_key_distance"(int8, int8, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int8_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_key_distance"(int8, int8, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_left_distance"(int8, int8);
CREATE FUNCTION "public"."rum_int8_left_distance"(int8, int8)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int8_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_left_distance"(int8, int8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_outer_distance"(int8, int8, int2);
CREATE FUNCTION "public"."rum_int8_outer_distance"(int8, int8, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int8_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_outer_distance"(int8, int8, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_int8_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_int8_right_distance"(int8, int8);
CREATE FUNCTION "public"."rum_int8_right_distance"(int8, int8)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_int8_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_int8_right_distance"(int8, int8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_internal_data_page_items
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_internal_data_page_items"("rel_name" text, "blk_num" int4);
CREATE FUNCTION "public"."rum_internal_data_page_items"("rel_name" text, "blk_num" int4)
  RETURNS TABLE("is_high_key" bool, "block_number" int4, "tuple_id" tid, "add_info_is_null" bool, "add_info" varchar) AS $BODY$
    SELECT *
    FROM rum_page_items_info(rel_name, blk_num, 1)
        AS rum_page_items_info(
            is_high_key bool,
            block_number int4,
            tuple_id tid,
            add_info_is_null bool,
            add_info varchar
        );
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."rum_internal_data_page_items"("rel_name" text, "blk_num" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_internal_entry_page_items
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_internal_entry_page_items"("rel_name" text, "blk_num" int4);
CREATE FUNCTION "public"."rum_internal_entry_page_items"("rel_name" text, "blk_num" int4)
  RETURNS TABLE("key" varchar, "attrnum" int4, "category" varchar, "down_link" int4) AS $BODY$
  SELECT *
  FROM rum_page_items_info(rel_name, blk_num, 3)
      AS rum_page_items_info(
          key varchar,
          attrnum int4,
          category varchar,
          down_link int4
      );
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."rum_internal_entry_page_items"("rel_name" text, "blk_num" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_interval_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_interval_compare_prefix"(interval, interval, int2, internal);
CREATE FUNCTION "public"."rum_interval_compare_prefix"(interval, interval, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_interval_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_interval_compare_prefix"(interval, interval, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_interval_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_interval_extract_query"(interval, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_interval_extract_query"(interval, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_interval_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_interval_extract_query"(interval, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_interval_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_interval_extract_value"(interval, internal);
CREATE FUNCTION "public"."rum_interval_extract_value"(interval, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_interval_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_interval_extract_value"(interval, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_leaf_data_page_items
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_leaf_data_page_items"("rel_name" text, "blk_num" int4);
CREATE FUNCTION "public"."rum_leaf_data_page_items"("rel_name" text, "blk_num" int4)
  RETURNS TABLE("is_high_key" bool, "tuple_id" tid, "add_info_is_null" bool, "add_info" varchar) AS $BODY$
    SELECT *
    FROM rum_page_items_info(rel_name, blk_num, 0)
        AS rum_page_items_info(
            is_high_key bool,
            tuple_id tid,
            add_info_is_null bool,
            add_info varchar
        );
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."rum_leaf_data_page_items"("rel_name" text, "blk_num" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_leaf_entry_page_items
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_leaf_entry_page_items"("rel_name" text, "blk_num" int4);
CREATE FUNCTION "public"."rum_leaf_entry_page_items"("rel_name" text, "blk_num" int4)
  RETURNS TABLE("key" varchar, "attrnum" int4, "category" varchar, "tuple_id" tid, "add_info_is_null" bool, "add_info" varchar, "is_posting_tree" bool, "posting_tree_root" int4) AS $BODY$
  SELECT *
  FROM rum_page_items_info(rel_name, blk_num, 2)
      AS rum_page_items_info(
          key varchar,
          attrnum int4,
          category varchar,
          tuple_id tid,
          add_info_is_null bool,
          add_info varchar,
          is_posting_tree bool,
          posting_tree_root int4
      );
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."rum_leaf_entry_page_items"("rel_name" text, "blk_num" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_macaddr_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_macaddr_compare_prefix"(macaddr, macaddr, int2, internal);
CREATE FUNCTION "public"."rum_macaddr_compare_prefix"(macaddr, macaddr, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_macaddr_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_macaddr_compare_prefix"(macaddr, macaddr, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_macaddr_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_macaddr_extract_query"(macaddr, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_macaddr_extract_query"(macaddr, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_macaddr_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_macaddr_extract_query"(macaddr, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_macaddr_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_macaddr_extract_value"(macaddr, internal);
CREATE FUNCTION "public"."rum_macaddr_extract_value"(macaddr, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_macaddr_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_macaddr_extract_value"(macaddr, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_metapage_info
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_metapage_info"("rel_name" text, "blk_num" int4, OUT "pending_head" int8, OUT "pending_tail" int8, OUT "tail_free_size" int4, OUT "n_pending_pages" int8, OUT "n_pending_tuples" int8, OUT "n_total_pages" int8, OUT "n_entry_pages" int8, OUT "n_data_pages" int8, OUT "n_entries" int8, OUT "version" varchar);
CREATE FUNCTION "public"."rum_metapage_info"(IN "rel_name" text, IN "blk_num" int4, OUT "pending_head" int8, OUT "pending_tail" int8, OUT "tail_free_size" int4, OUT "n_pending_pages" int8, OUT "n_pending_tuples" int8, OUT "n_total_pages" int8, OUT "n_entry_pages" int8, OUT "n_data_pages" int8, OUT "n_entries" int8, OUT "version" varchar)
  RETURNS "pg_catalog"."record" AS '$libdir/rum', 'rum_metapage_info'
  LANGUAGE c VOLATILE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_metapage_info"("rel_name" text, "blk_num" int4, OUT "pending_head" int8, OUT "pending_tail" int8, OUT "tail_free_size" int4, OUT "n_pending_pages" int8, OUT "n_pending_tuples" int8, OUT "n_total_pages" int8, OUT "n_entry_pages" int8, OUT "n_data_pages" int8, OUT "n_entries" int8, OUT "version" varchar) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_compare_prefix"(money, money, int2, internal);
CREATE FUNCTION "public"."rum_money_compare_prefix"(money, money, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_money_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_compare_prefix"(money, money, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_config"(internal);
CREATE FUNCTION "public"."rum_money_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_money_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_distance"(money, money);
CREATE FUNCTION "public"."rum_money_distance"(money, money)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_money_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_distance"(money, money) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_extract_query"(money, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_money_extract_query"(money, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_money_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_extract_query"(money, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_extract_value"(money, internal);
CREATE FUNCTION "public"."rum_money_extract_value"(money, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_money_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_extract_value"(money, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_key_distance"(money, money, int2);
CREATE FUNCTION "public"."rum_money_key_distance"(money, money, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_money_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_key_distance"(money, money, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_left_distance"(money, money);
CREATE FUNCTION "public"."rum_money_left_distance"(money, money)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_money_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_left_distance"(money, money) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_outer_distance"(money, money, int2);
CREATE FUNCTION "public"."rum_money_outer_distance"(money, money, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_money_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_outer_distance"(money, money, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_money_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_money_right_distance"(money, money);
CREATE FUNCTION "public"."rum_money_right_distance"(money, money)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_money_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_money_right_distance"(money, money) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_numeric_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_numeric_cmp"(numeric, numeric);
CREATE FUNCTION "public"."rum_numeric_cmp"(numeric, numeric)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_numeric_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_numeric_cmp"(numeric, numeric) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_numeric_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_numeric_compare_prefix"(numeric, numeric, int2, internal);
CREATE FUNCTION "public"."rum_numeric_compare_prefix"(numeric, numeric, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_numeric_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_numeric_compare_prefix"(numeric, numeric, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_numeric_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_numeric_extract_query"(numeric, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_numeric_extract_query"(numeric, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_numeric_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_numeric_extract_query"(numeric, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_numeric_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_numeric_extract_value"(numeric, internal);
CREATE FUNCTION "public"."rum_numeric_extract_value"(numeric, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_numeric_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_numeric_extract_value"(numeric, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_compare_prefix"(oid, oid, int2, internal);
CREATE FUNCTION "public"."rum_oid_compare_prefix"(oid, oid, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_oid_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_compare_prefix"(oid, oid, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_config"(internal);
CREATE FUNCTION "public"."rum_oid_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_oid_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_distance"(oid, oid);
CREATE FUNCTION "public"."rum_oid_distance"(oid, oid)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_oid_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_distance"(oid, oid) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_extract_query"(oid, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_oid_extract_query"(oid, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_oid_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_extract_query"(oid, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_extract_value"(oid, internal);
CREATE FUNCTION "public"."rum_oid_extract_value"(oid, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_oid_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_extract_value"(oid, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_key_distance"(oid, oid, int2);
CREATE FUNCTION "public"."rum_oid_key_distance"(oid, oid, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_oid_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_key_distance"(oid, oid, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_left_distance"(oid, oid);
CREATE FUNCTION "public"."rum_oid_left_distance"(oid, oid)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_oid_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_left_distance"(oid, oid) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_outer_distance"(oid, oid, int2);
CREATE FUNCTION "public"."rum_oid_outer_distance"(oid, oid, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_oid_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_outer_distance"(oid, oid, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_oid_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_oid_right_distance"(oid, oid);
CREATE FUNCTION "public"."rum_oid_right_distance"(oid, oid)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_oid_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_oid_right_distance"(oid, oid) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_page_items_info
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_page_items_info"("rel_name" text, "blk_num" int4, "page_type" int4);
CREATE FUNCTION "public"."rum_page_items_info"("rel_name" text, "blk_num" int4, "page_type" int4)
  RETURNS SETOF "pg_catalog"."record" AS '$libdir/rum', 'rum_page_items_info'
  LANGUAGE c VOLATILE STRICT
  COST 1
  ROWS 1000;
ALTER FUNCTION "public"."rum_page_items_info"("rel_name" text, "blk_num" int4, "page_type" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_page_opaque_info
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_page_opaque_info"("rel_name" text, "blk_num" int4, OUT "leftlink" int8, OUT "rightlink" int8, OUT "maxoff" int4, OUT "freespace" int4, OUT "flags" _text);
CREATE FUNCTION "public"."rum_page_opaque_info"(IN "rel_name" text, IN "blk_num" int4, OUT "leftlink" int8, OUT "rightlink" int8, OUT "maxoff" int4, OUT "freespace" int4, OUT "flags" _text)
  RETURNS "pg_catalog"."record" AS '$libdir/rum', 'rum_page_opaque_info'
  LANGUAGE c VOLATILE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_page_opaque_info"("rel_name" text, "blk_num" int4, OUT "leftlink" int8, OUT "rightlink" int8, OUT "maxoff" int4, OUT "freespace" int4, OUT "flags" _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_text_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_text_compare_prefix"(text, text, int2, internal);
CREATE FUNCTION "public"."rum_text_compare_prefix"(text, text, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_text_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_text_compare_prefix"(text, text, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_text_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_text_extract_query"(text, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_text_extract_query"(text, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_text_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_text_extract_query"(text, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_text_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_text_extract_value"(text, internal);
CREATE FUNCTION "public"."rum_text_extract_value"(text, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_text_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_text_extract_value"(text, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_time_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_time_compare_prefix"(time, time, int2, internal);
CREATE FUNCTION "public"."rum_time_compare_prefix"(time, time, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_time_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_time_compare_prefix"(time, time, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_time_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_time_extract_query"(time, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_time_extract_query"(time, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_time_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_time_extract_query"(time, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_time_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_time_extract_value"(time, internal);
CREATE FUNCTION "public"."rum_time_extract_value"(time, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_time_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_time_extract_value"(time, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_compare_prefix"(timestamp, timestamp, int2, internal);
CREATE FUNCTION "public"."rum_timestamp_compare_prefix"(timestamp, timestamp, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_timestamp_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_compare_prefix"(timestamp, timestamp, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_config"(internal);
CREATE FUNCTION "public"."rum_timestamp_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_timestamp_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_consistent"(internal, int2, timestamp, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_timestamp_consistent"(internal, int2, timestamp, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_timestamp_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_consistent"(internal, int2, timestamp, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_distance"(timestamp, timestamp);
CREATE FUNCTION "public"."rum_timestamp_distance"(timestamp, timestamp)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_distance"(timestamp, timestamp) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_extract_query"(timestamp, internal, int2, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_timestamp_extract_query"(timestamp, internal, int2, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_timestamp_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_extract_query"(timestamp, internal, int2, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_extract_value"(timestamp, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_timestamp_extract_value"(timestamp, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_timestamp_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_extract_value"(timestamp, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_key_distance"(timestamp, timestamp, int2);
CREATE FUNCTION "public"."rum_timestamp_key_distance"(timestamp, timestamp, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_key_distance"(timestamp, timestamp, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_left_distance"(timestamp, timestamp);
CREATE FUNCTION "public"."rum_timestamp_left_distance"(timestamp, timestamp)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_left_distance"(timestamp, timestamp) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_outer_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_outer_distance"(timestamp, timestamp, int2);
CREATE FUNCTION "public"."rum_timestamp_outer_distance"(timestamp, timestamp, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_outer_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_outer_distance"(timestamp, timestamp, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamp_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamp_right_distance"(timestamp, timestamp);
CREATE FUNCTION "public"."rum_timestamp_right_distance"(timestamp, timestamp)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamp_right_distance"(timestamp, timestamp) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamptz_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamptz_distance"(timestamptz, timestamptz);
CREATE FUNCTION "public"."rum_timestamptz_distance"(timestamptz, timestamptz)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamptz_distance"(timestamptz, timestamptz) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamptz_key_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamptz_key_distance"(timestamptz, timestamptz, int2);
CREATE FUNCTION "public"."rum_timestamptz_key_distance"(timestamptz, timestamptz, int2)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamptz_key_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamptz_key_distance"(timestamptz, timestamptz, int2) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamptz_left_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamptz_left_distance"(timestamptz, timestamptz);
CREATE FUNCTION "public"."rum_timestamptz_left_distance"(timestamptz, timestamptz)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_left_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamptz_left_distance"(timestamptz, timestamptz) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timestamptz_right_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timestamptz_right_distance"(timestamptz, timestamptz);
CREATE FUNCTION "public"."rum_timestamptz_right_distance"(timestamptz, timestamptz)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_timestamp_right_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timestamptz_right_distance"(timestamptz, timestamptz) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timetz_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timetz_compare_prefix"(timetz, timetz, int2, internal);
CREATE FUNCTION "public"."rum_timetz_compare_prefix"(timetz, timetz, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_timetz_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timetz_compare_prefix"(timetz, timetz, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timetz_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timetz_extract_query"(timetz, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_timetz_extract_query"(timetz, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_timetz_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timetz_extract_query"(timetz, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_timetz_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_timetz_extract_value"(timetz, internal);
CREATE FUNCTION "public"."rum_timetz_extract_value"(timetz, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_timetz_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_timetz_extract_value"(timetz, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_distance"(tsvector, tsquery);
CREATE FUNCTION "public"."rum_ts_distance"(tsvector, tsquery)
  RETURNS "pg_catalog"."float4" AS '$libdir/rum', 'rum_ts_distance_tt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_distance"(tsvector, tsquery) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_distance"(tsvector, "public"."rum_distance_query");
CREATE FUNCTION "public"."rum_ts_distance"(tsvector, "public"."rum_distance_query")
  RETURNS "pg_catalog"."float4" AS '$libdir/rum', 'rum_ts_distance_td'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_distance"(tsvector, "public"."rum_distance_query") OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_distance"(tsvector, tsquery, int4);
CREATE FUNCTION "public"."rum_ts_distance"(tsvector, tsquery, int4)
  RETURNS "pg_catalog"."float4" AS '$libdir/rum', 'rum_ts_distance_ttf'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_distance"(tsvector, tsquery, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_join_pos
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_join_pos"(internal, internal);
CREATE FUNCTION "public"."rum_ts_join_pos"(internal, internal)
  RETURNS "pg_catalog"."bytea" AS '$libdir/rum', 'rum_ts_join_pos'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_join_pos"(internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_score
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_score"(tsvector, tsquery);
CREATE FUNCTION "public"."rum_ts_score"(tsvector, tsquery)
  RETURNS "pg_catalog"."float4" AS '$libdir/rum', 'rum_ts_score_tt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_score"(tsvector, tsquery) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_score
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_score"(tsvector, tsquery, int4);
CREATE FUNCTION "public"."rum_ts_score"(tsvector, tsquery, int4)
  RETURNS "pg_catalog"."float4" AS '$libdir/rum', 'rum_ts_score_ttf'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_score"(tsvector, tsquery, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_ts_score
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_ts_score"(tsvector, "public"."rum_distance_query");
CREATE FUNCTION "public"."rum_ts_score"(tsvector, "public"."rum_distance_query")
  RETURNS "pg_catalog"."float4" AS '$libdir/rum', 'rum_ts_score_td'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_ts_score"(tsvector, "public"."rum_distance_query") OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_tsquery_addon_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_tsquery_addon_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_tsquery_addon_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_tsquery_timestamp_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_tsquery_addon_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_tsquery_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_tsquery_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_tsquery_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_tsquery_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_tsquery_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_tsquery_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_tsquery_distance"(internal, int2, tsvector, int4, internal, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_tsquery_distance"(internal, int2, tsvector, int4, internal, internal, internal, internal, internal)
  RETURNS "pg_catalog"."float8" AS '$libdir/rum', 'rum_tsquery_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_tsquery_distance"(internal, int2, tsvector, int4, internal, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_tsquery_pre_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_tsquery_pre_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."rum_tsquery_pre_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'rum_tsquery_pre_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_tsquery_pre_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_tsvector_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_tsvector_config"(internal);
CREATE FUNCTION "public"."rum_tsvector_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'rum_tsvector_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_tsvector_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_varbit_compare_prefix
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_varbit_compare_prefix"(varbit, varbit, int2, internal);
CREATE FUNCTION "public"."rum_varbit_compare_prefix"(varbit, varbit, int2, internal)
  RETURNS "pg_catalog"."int4" AS '$libdir/rum', 'rum_varbit_compare_prefix'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_varbit_compare_prefix"(varbit, varbit, int2, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_varbit_extract_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_varbit_extract_query"(varbit, internal, int2, internal, internal);
CREATE FUNCTION "public"."rum_varbit_extract_query"(varbit, internal, int2, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_varbit_extract_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_varbit_extract_query"(varbit, internal, int2, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rum_varbit_extract_value
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rum_varbit_extract_value"(varbit, internal);
CREATE FUNCTION "public"."rum_varbit_extract_value"(varbit, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'rum_varbit_extract_value'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."rum_varbit_extract_value"(varbit, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for rumhandler
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."rumhandler"(internal);
CREATE FUNCTION "public"."rumhandler"(internal)
  RETURNS "pg_catalog"."index_am_handler" AS '$libdir/rum', 'rumhandler'
  LANGUAGE c VOLATILE
  COST 1;
ALTER FUNCTION "public"."rumhandler"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ruminv_extract_tsquery
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ruminv_extract_tsquery"(tsquery, internal, internal, internal, internal);
CREATE FUNCTION "public"."ruminv_extract_tsquery"(tsquery, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'ruminv_extract_tsquery'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ruminv_extract_tsquery"(tsquery, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ruminv_extract_tsvector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ruminv_extract_tsvector"(tsvector, internal, int2, internal, internal, internal, internal);
CREATE FUNCTION "public"."ruminv_extract_tsvector"(tsvector, internal, int2, internal, internal, internal, internal)
  RETURNS "pg_catalog"."internal" AS '$libdir/rum', 'ruminv_extract_tsvector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ruminv_extract_tsvector"(tsvector, internal, int2, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ruminv_tsquery_config
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ruminv_tsquery_config"(internal);
CREATE FUNCTION "public"."ruminv_tsquery_config"(internal)
  RETURNS "pg_catalog"."void" AS '$libdir/rum', 'ruminv_tsquery_config'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ruminv_tsquery_config"(internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for ruminv_tsvector_consistent
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ruminv_tsvector_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal);
CREATE FUNCTION "public"."ruminv_tsvector_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal)
  RETURNS "pg_catalog"."bool" AS '$libdir/rum', 'ruminv_tsvector_consistent'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."ruminv_tsvector_consistent"(internal, int2, tsvector, int4, internal, internal, internal, internal) OWNER TO "postgres";

-- ----------------------------
-- Function structure for skeys
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."skeys"("public"."hstore");
CREATE FUNCTION "public"."skeys"("public"."hstore")
  RETURNS SETOF "pg_catalog"."text" AS '$libdir/hstore', 'hstore_skeys'
  LANGUAGE c IMMUTABLE STRICT
  COST 1
  ROWS 1000;
ALTER FUNCTION "public"."skeys"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for slice
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."slice"("public"."hstore", _text);
CREATE FUNCTION "public"."slice"("public"."hstore", _text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_slice_to_hstore'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."slice"("public"."hstore", _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for slice_array
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."slice_array"("public"."hstore", _text);
CREATE FUNCTION "public"."slice_array"("public"."hstore", _text)
  RETURNS "pg_catalog"."_text" AS '$libdir/hstore', 'hstore_slice_to_array'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."slice_array"("public"."hstore", _text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec"("public"."sparsevec", int4, bool);
CREATE FUNCTION "public"."sparsevec"("public"."sparsevec", int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec"("public"."sparsevec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_cmp"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_cmp"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'sparsevec_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_cmp"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_eq
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_eq"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_eq"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'sparsevec_eq'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_eq"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_ge
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_ge"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_ge"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'sparsevec_ge'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_ge"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_gt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_gt"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_gt"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'sparsevec_gt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_gt"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_in"(cstring, oid, int4);
CREATE FUNCTION "public"."sparsevec_in"(cstring, oid, int4)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'sparsevec_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_in"(cstring, oid, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_l2_squared_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_l2_squared_distance"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_l2_squared_distance"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_l2_squared_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_l2_squared_distance"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_le
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_le"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_le"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'sparsevec_le'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_le"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_lt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_lt"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_lt"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'sparsevec_lt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_lt"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_ne
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_ne"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_ne"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'sparsevec_ne'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_ne"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_negative_inner_product
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_negative_inner_product"("public"."sparsevec", "public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_negative_inner_product"("public"."sparsevec", "public"."sparsevec")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'sparsevec_negative_inner_product'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_negative_inner_product"("public"."sparsevec", "public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_out
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_out"("public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_out"("public"."sparsevec")
  RETURNS "pg_catalog"."cstring" AS '$libdir/vector', 'sparsevec_out'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_out"("public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_recv
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_recv"(internal, oid, int4);
CREATE FUNCTION "public"."sparsevec_recv"(internal, oid, int4)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'sparsevec_recv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_recv"(internal, oid, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_send
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_send"("public"."sparsevec");
CREATE FUNCTION "public"."sparsevec_send"("public"."sparsevec")
  RETURNS "pg_catalog"."bytea" AS '$libdir/vector', 'sparsevec_send'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_send"("public"."sparsevec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_to_halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_to_halfvec"("public"."sparsevec", int4, bool);
CREATE FUNCTION "public"."sparsevec_to_halfvec"("public"."sparsevec", int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'sparsevec_to_halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_to_halfvec"("public"."sparsevec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_to_vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_to_vector"("public"."sparsevec", int4, bool);
CREATE FUNCTION "public"."sparsevec_to_vector"("public"."sparsevec", int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'sparsevec_to_vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_to_vector"("public"."sparsevec", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for sparsevec_typmod_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."sparsevec_typmod_in"(_cstring);
CREATE FUNCTION "public"."sparsevec_typmod_in"(_cstring)
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'sparsevec_typmod_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."sparsevec_typmod_in"(_cstring) OWNER TO "postgres";

-- ----------------------------
-- Function structure for subvector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."subvector"("public"."vector", int4, int4);
CREATE FUNCTION "public"."subvector"("public"."vector", int4, int4)
  RETURNS "public"."vector" AS '$libdir/vector', 'subvector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."subvector"("public"."vector", int4, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for subvector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."subvector"("public"."halfvec", int4, int4);
CREATE FUNCTION "public"."subvector"("public"."halfvec", int4, int4)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'halfvec_subvector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."subvector"("public"."halfvec", int4, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for svals
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."svals"("public"."hstore");
CREATE FUNCTION "public"."svals"("public"."hstore")
  RETURNS SETOF "pg_catalog"."text" AS '$libdir/hstore', 'hstore_svals'
  LANGUAGE c IMMUTABLE STRICT
  COST 1
  ROWS 1000;
ALTER FUNCTION "public"."svals"("public"."hstore") OWNER TO "postgres";

-- ----------------------------
-- Function structure for tconvert
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."tconvert"(text, text);
CREATE FUNCTION "public"."tconvert"(text, text)
  RETURNS "public"."hstore" AS '$libdir/hstore', 'hstore_from_text'
  LANGUAGE c IMMUTABLE
  COST 1;
ALTER FUNCTION "public"."tconvert"(text, text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for tsquery_to_distance_query
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."tsquery_to_distance_query"(tsquery);
CREATE FUNCTION "public"."tsquery_to_distance_query"(tsquery)
  RETURNS "public"."rum_distance_query" AS '$libdir/rum', 'tsquery_to_distance_query'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."tsquery_to_distance_query"(tsquery) OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_generate_v1
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_generate_v1"();
CREATE FUNCTION "public"."uuid_generate_v1"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1'
  LANGUAGE c VOLATILE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_generate_v1"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_generate_v1mc
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_generate_v1mc"();
CREATE FUNCTION "public"."uuid_generate_v1mc"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1mc'
  LANGUAGE c VOLATILE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_generate_v1mc"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_generate_v3
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_generate_v3"("namespace" uuid, "name" text);
CREATE FUNCTION "public"."uuid_generate_v3"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v3'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_generate_v3"("namespace" uuid, "name" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_generate_v4
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_generate_v4"();
CREATE FUNCTION "public"."uuid_generate_v4"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v4'
  LANGUAGE c VOLATILE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_generate_v4"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_generate_v5
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_generate_v5"("namespace" uuid, "name" text);
CREATE FUNCTION "public"."uuid_generate_v5"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v5'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_generate_v5"("namespace" uuid, "name" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_nil
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_nil"();
CREATE FUNCTION "public"."uuid_nil"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_nil'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_nil"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_ns_dns
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_ns_dns"();
CREATE FUNCTION "public"."uuid_ns_dns"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_dns'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_ns_dns"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_ns_oid
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_ns_oid"();
CREATE FUNCTION "public"."uuid_ns_oid"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_oid'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_ns_oid"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_ns_url
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_ns_url"();
CREATE FUNCTION "public"."uuid_ns_url"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_url'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_ns_url"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for uuid_ns_x500
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."uuid_ns_x500"();
CREATE FUNCTION "public"."uuid_ns_x500"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_x500'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."uuid_ns_x500"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector"("public"."vector", int4, bool);
CREATE FUNCTION "public"."vector"("public"."vector", int4, bool)
  RETURNS "public"."vector" AS '$libdir/vector', 'vector'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector"("public"."vector", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_accum
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_accum"(_float8, "public"."vector");
CREATE FUNCTION "public"."vector_accum"(_float8, "public"."vector")
  RETURNS "pg_catalog"."_float8" AS '$libdir/vector', 'vector_accum'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_accum"(_float8, "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_add"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_add"("public"."vector", "public"."vector")
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_add'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_add"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_avg
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_avg"(_float8);
CREATE FUNCTION "public"."vector_avg"(_float8)
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_avg'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_avg"(_float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_cmp
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_cmp"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_cmp"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'vector_cmp'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_cmp"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_combine
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_combine"(_float8, _float8);
CREATE FUNCTION "public"."vector_combine"(_float8, _float8)
  RETURNS "pg_catalog"."_float8" AS '$libdir/vector', 'vector_combine'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_combine"(_float8, _float8) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_concat
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_concat"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_concat"("public"."vector", "public"."vector")
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_concat'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_concat"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_dims
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_dims"("public"."halfvec");
CREATE FUNCTION "public"."vector_dims"("public"."halfvec")
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'halfvec_vector_dims'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_dims"("public"."halfvec") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_dims
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_dims"("public"."vector");
CREATE FUNCTION "public"."vector_dims"("public"."vector")
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'vector_dims'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_dims"("public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_eq
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_eq"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_eq"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'vector_eq'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_eq"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_ge
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_ge"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_ge"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'vector_ge'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_ge"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_gt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_gt"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_gt"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'vector_gt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_gt"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_in"(cstring, oid, int4);
CREATE FUNCTION "public"."vector_in"(cstring, oid, int4)
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_in"(cstring, oid, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_l2_squared_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_l2_squared_distance"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_l2_squared_distance"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'vector_l2_squared_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_l2_squared_distance"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_le
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_le"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_le"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'vector_le'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_le"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_lt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_lt"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_lt"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'vector_lt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_lt"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_mul
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_mul"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_mul"("public"."vector", "public"."vector")
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_mul'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_mul"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_ne
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_ne"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_ne"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."bool" AS '$libdir/vector', 'vector_ne'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_ne"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_negative_inner_product
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_negative_inner_product"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_negative_inner_product"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'vector_negative_inner_product'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_negative_inner_product"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_norm
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_norm"("public"."vector");
CREATE FUNCTION "public"."vector_norm"("public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'vector_norm'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_norm"("public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_out
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_out"("public"."vector");
CREATE FUNCTION "public"."vector_out"("public"."vector")
  RETURNS "pg_catalog"."cstring" AS '$libdir/vector', 'vector_out'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_out"("public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_recv
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_recv"(internal, oid, int4);
CREATE FUNCTION "public"."vector_recv"(internal, oid, int4)
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_recv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_recv"(internal, oid, int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_send
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_send"("public"."vector");
CREATE FUNCTION "public"."vector_send"("public"."vector")
  RETURNS "pg_catalog"."bytea" AS '$libdir/vector', 'vector_send'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_send"("public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_spherical_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_spherical_distance"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_spherical_distance"("public"."vector", "public"."vector")
  RETURNS "pg_catalog"."float8" AS '$libdir/vector', 'vector_spherical_distance'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_spherical_distance"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_sub
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_sub"("public"."vector", "public"."vector");
CREATE FUNCTION "public"."vector_sub"("public"."vector", "public"."vector")
  RETURNS "public"."vector" AS '$libdir/vector', 'vector_sub'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_sub"("public"."vector", "public"."vector") OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_to_float4
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_to_float4"("public"."vector", int4, bool);
CREATE FUNCTION "public"."vector_to_float4"("public"."vector", int4, bool)
  RETURNS "pg_catalog"."_float4" AS '$libdir/vector', 'vector_to_float4'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_to_float4"("public"."vector", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_to_halfvec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_to_halfvec"("public"."vector", int4, bool);
CREATE FUNCTION "public"."vector_to_halfvec"("public"."vector", int4, bool)
  RETURNS "public"."halfvec" AS '$libdir/vector', 'vector_to_halfvec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_to_halfvec"("public"."vector", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_to_sparsevec
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_to_sparsevec"("public"."vector", int4, bool);
CREATE FUNCTION "public"."vector_to_sparsevec"("public"."vector", int4, bool)
  RETURNS "public"."sparsevec" AS '$libdir/vector', 'vector_to_sparsevec'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_to_sparsevec"("public"."vector", int4, bool) OWNER TO "postgres";

-- ----------------------------
-- Function structure for vector_typmod_in
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vector_typmod_in"(_cstring);
CREATE FUNCTION "public"."vector_typmod_in"(_cstring)
  RETURNS "pg_catalog"."int4" AS '$libdir/vector', 'vector_typmod_in'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;
ALTER FUNCTION "public"."vector_typmod_in"(_cstring) OWNER TO "postgres";

-- ----------------------------
-- Indexes structure for table vector_store
-- ----------------------------
CREATE INDEX "idx_vector_store_embedding" ON "public"."vector_store" USING hnsw (
  "embedding" "public"."vector_cosine_ops"
);

-- ----------------------------
-- Primary Key structure for table vector_store
-- ----------------------------
ALTER TABLE "public"."vector_store" ADD CONSTRAINT "vector_store_pkey" PRIMARY KEY ("id");
