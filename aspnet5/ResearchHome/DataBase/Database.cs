using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ResearchHome.DataBase
{
    public interface IDatabase : IDisposable
    {
        IDbConnection Connection { get; }

        IEnumerable<T> QueryListSQL<T>(string sql, object param = null) where T : class;

        IEnumerable<T> QueryListSQL<T>(string sql, Dictionary<string, object> param) where T : class;

        T QuerySQL<T>(string sql, object param = null);

        T QuerySQL<T>(string sql, Dictionary<string, object> param);

        Task<int?> CreateAsync<T>(T model);

        Task<bool> UpdateAsync<T>(T model);

        Task<IEnumerable<T>> QueryList<T>();

        T Single<T>(string sql);
        Task<object> ExecuteScalarAsync(string sql, object param = null);

        bool RunInTransaction(Action action);

        bool ExecuteSQL(string sql);

        bool ExecuteSQL(string sql, object param);

        //Task<bool> ExecuteSQL(string sql, object param = null);

        bool TransactionExecuteSQL(string sql);

        bool ExecuteSQL(string sql, Dictionary<string, object> param = null);

        bool UpdateSQL(string tableName, params DataColumn[] dataColumns);

       bool TransactionUpdateSQL(string tableName, params DataColumn[] dataColumns);

        bool InsertSQL(string tableName, params DataColumn[] dataColumns);

        bool TransactionInsertSQL(string tableName, params DataColumn[] dataColumns);
    }

    public class Database : IDatabase
    {
        public Database(IOptions<DataBaseOptions> options)
        {
            Connection = options.Value.DbConnection();

            if (Connection.State != ConnectionState.Open)
            {
                Connection.Open();
            }
        }

        //public async Task<bool> ExecuteSQL(string sql, object param = null) => await Connection.ExecuteAsync(sql, param) > 0;


        public IDbConnection Connection { get; }

        IDbConnection IDatabase.Connection => Connection;

        public void Dispose()
        {
            if (Connection.State != ConnectionState.Closed)
            {
                Connection.Close();
            }
        }

        public IEnumerable<T> QueryListSQL<T>(string sql, object param = null) where T : class
        {
            try
            {
                return Connection.Query<T>(sql, param);
            }
            catch (Exception exception)
            {
                return null;
            }
        }

        public IEnumerable<T> QueryListSQL<T>(string sql, Dictionary<string, object> param) where T : class
        {
            var dapperParams = GetDynamicParameters(param);
            return QueryListSQL<T>(sql, dapperParams);
        }

        public T QuerySQL<T>(string sql, object param)
        {
            try
            {
                return Connection.Query<T>(sql, param).ToList().FirstOrDefault();
            }
            catch (Exception exception)
            {
                return default(T);
            }
        }
        public T QuerySQL<T>(string sql, Dictionary<string, object> param)
        {
            var dapperParams = GetDynamicParameters(param);
            return QuerySQL<T>(sql,dapperParams);
        }

        public async Task<int?> CreateAsync<T>(T model) => await Connection.InsertAsync(model);

        public async Task<bool> UpdateAsync<T>(T model) => await Connection.UpdateAsync(model) > 0;

        public async Task<IEnumerable<T>> QueryList<T>() => await Connection.GetListAsync<T>();

        public T Single<T>(string sql) => Connection.QueryFirstOrDefault<T>(sql);

        public async Task<object> ExecuteScalarAsync(string sql, object param = null) => await Connection.ExecuteScalarAsync(sql, param);

        bool IDatabase.ExecuteSQL(string sql)
        {
            try
            {
                return Connection.Execute(sql) > 0;
            }
            catch (Exception exception)
            {
                return false;
            }
        }

        bool IDatabase.ExecuteSQL(string sql, object param)
        => Connection.Execute(sql, param) > 0;

        bool IDatabase.TransactionExecuteSQL(string sql)
        => Connection.Execute(sql) > 0;

        private DynamicParameters GetDynamicParameters(Dictionary<string, object> param)
        {
            var dapperDynamicParamters = new DynamicParameters();
            foreach (var item in param)
            {
                dapperDynamicParamters.Add(item.Key, item.Value);
            }
            return dapperDynamicParamters;
        }

        private DynamicParameters GetDynamicParameters(DataColumn[] dataColumns)
        {
            var dapperDynamicParamters = new DynamicParameters();
            foreach (var item in dataColumns)
            {
                dapperDynamicParamters.Add($"@{item.ColumnName}", item.ColumnValue);
            }
            return dapperDynamicParamters;
        }

        public bool ExecuteSQL(string sql, Dictionary<string, object> param)
        {
            try
            {
                var dapperDynamicParamters = GetDynamicParameters(param);
                return Connection.Execute(sql, dapperDynamicParamters) > 0;
            }
            catch (Exception exception)
            {
                return false;
            }
        }

        public bool UpdateSQL(string tableName, params DataColumn[] dataColumns)
        {
            try
            {
                return TransactionUpdateSQL(tableName, dataColumns);
            }
            catch (Exception exception)
            {
                return false;
            }
        }
        
        public bool TransactionUpdateSQL(string tableName, params DataColumn[] dataColumns)
        {
            try
            {
                var dataUpdateColumns = dataColumns.Where(item => !item.IsWhere);
                var dataWhereColumns = dataColumns.Where(item => item.IsWhere);
                var sqlBuilder = new StringBuilder($"UPDATE {tableName} SET ");
                foreach (var item in dataUpdateColumns)
                {
                    if (item == null) continue;
                    sqlBuilder.Append($"{item.ColumnName} = @{item.ColumnName},");
                }
                if (dataUpdateColumns.Count() > 0) sqlBuilder.Remove(sqlBuilder.Length - 1, 1);
                sqlBuilder.Append(" WHERE 1=1 ");
                foreach (var item in dataWhereColumns)
                {
                    if (item == null) continue;
                    sqlBuilder.Append($" AND {item.ColumnName} = @{item.ColumnName}");
                }
                if (dataUpdateColumns.Count() == 0 || dataWhereColumns.Count() == 0) return false;
                var dapperDynamicParamters = GetDynamicParameters(dataColumns);
                return Connection.Execute(sqlBuilder.ToString(), dapperDynamicParamters) > 0;
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }

        public bool InsertSQL(string tableName, params DataColumn[] dataColumns)
        {
            try
            {
                return TransactionInsertSQL(tableName,dataColumns);
            }
            catch (Exception exception)
            {
                return false;
            }
        }
        public bool TransactionInsertSQL(string tableName, params DataColumn[] dataColumns)
        {
            try
            {
                if (dataColumns.Count() == 0) return false;
                var sqlBuilder = new StringBuilder($"INSERT INTO {tableName}( ");
                foreach (var item in dataColumns)
                {
                    if (item == null) continue;
                    sqlBuilder.Append($"{item.ColumnName},");
                }
                sqlBuilder.Remove(sqlBuilder.Length - 1, 1);
                sqlBuilder.Append(") VALUES(");
                foreach (var item in dataColumns)
                {
                    sqlBuilder.Append($"@{item.ColumnName},");
                }
                sqlBuilder.Remove(sqlBuilder.Length - 1, 1);
                sqlBuilder.Append(")");
                var dapperDynamicParamters = GetDynamicParameters(dataColumns);
                return Connection.Execute(sqlBuilder.ToString(), dapperDynamicParamters) > 0;
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }

        private IDbTransaction _transaction;

        public bool HasActiveTransaction => _transaction != null;

        public bool RunInTransaction(Action action)
        {
            BeginTransaction();
            try
            {
                action();
                Commit();
            }
            catch (Exception ex)
            {
                if (HasActiveTransaction)
                {
                    Rollback();
                }
                return false;
            }
            return true;
        }

        public void BeginTransaction(IsolationLevel isolationLevel = IsolationLevel.ReadCommitted)
        {
            _transaction = Connection.BeginTransaction(isolationLevel);
        }

        public void Commit()
        {
            _transaction?.Commit();
            _transaction = null;
        }

        public void Rollback()
        {
            _transaction.Rollback();
            _transaction = null;
        }
    }

    public class DataColumn
    {
        public string ColumnName;
        public object ColumnValue;
        public bool IsWhere;

        public DataColumn()
        {
        }

        public DataColumn(string columnName, object columnValue, bool isWhere = false)
        {
            ColumnName = columnName;
            ColumnValue = columnValue;
            IsWhere = isWhere;
        }
    }

    public class DataBaseOptions
    {
        public Func<IDbConnection> DbConnection { get; set; }
    }
}
