using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.Configuration
{
    
        public class SysTypeInfo
        {/// <summary>
         /// Unique name of the setting.
         /// </summary>
            public string Name { get; private set; }

            /// <summary>
            /// Display name of the setting.
            /// This can be used to show setting to the user.
            /// </summary>
            public string DisplayName { get; set; }

            /// <summary>
            /// A brief description for this setting.
            /// </summary>
            public string Description { get; set; }

            /// <summary>
            /// Scopes of this setting.
            /// Default value: <see cref="SettingScopes.Application"/>.
            /// </summary>
            public string Scopes { get; set; }

            /// <summary>
            /// Is this setting inherited from parent scopes.
            /// Default: True.
            /// </summary>
            public bool IsInherited { get; set; }

            ///// <summary>
            ///// Gets/sets group for this setting.
            ///// </summary>
            //public SettingDefinitionGroup Group { get; set; }

            /// <summary>
            /// Default value of the setting.
            /// </summary>
            public string DefaultValue { get; set; }

            /// <summary>
            /// Can clients see this setting and it's value.
            /// It maybe dangerous for some settings to be visible to clients (such as email server password).
            /// Default: false.
            /// </summary>
            //[Obsolete("Use ClientVisibilityProvider instead.")]
            public bool IsVisibleToClients { get; set; }

            ///// <summary>
            ///// Client visibility definition for the setting.
            ///// </summary>
            //public ISettingClientVisibilityProvider ClientVisibilityProvider { get; set; }

            /// <summary>
            /// Can be used to store a custom object related to this setting.
            /// </summary>
            public object CustomData { get; set; }
        } 
}
