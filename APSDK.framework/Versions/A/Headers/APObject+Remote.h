//
//  APObject+Remote.h
//  AnyPresence SDK
//

/*!
 @header APObject+Remote
 @abstract Remote category for APObject class
 */

#import <Foundation/Foundation.h>
#import "APObject.h"
#import "Typedefs.h"

/*!
 @const kAPObjectRemoteErrorDictionaryKey
 @abstract Key that points to a dictionary of errors returned by the server.
 */
extern NSString * const kAPObjectRemoteErrorDictionaryKey;

/*!
 @category APObject (Remote)
 @abstract Adds remote CRUD capabilities to APObject instances.
 @discussion All public properties are passed on to the remote server.
 Make sure to set base URL for the remote API with @link //apple_ref/occ/intfm/APObject/setBaseURL: @/link prior to use.
 Use @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link to set the primary key property.
 */
@interface APObject (Remote)

#pragma mark -
#pragma mark Configuration

/*!
 @methodgroup Configuration
 */

/*!
 @method setBaseURL:
 @abstract Sets base URL for remote API.
 @param url Base URL for remote API (e.g. http://www.myserver.com/api/v1/).
 */
+ (void)setBaseURL:(NSURL*)url;

#pragma mark -
#pragma mark CRUD

/*!
 @methodgroup CRUD Methods (Synchronuous)
 */

/*!
 @method create:
 @abstract Persists new object on remote server.
 @param error Error that has occured while executing the request, if any.
 @result YES if the operation succeeded.
 @discussion Make sure to set the primary key unless it is generated by the server.
 */
- (BOOL)create:(NSError **)error;
/*!
 @method update:
 @abstract Updates existing object on remote server.
 @param error Error that has occured while executing the request, if any.
 @result YES if the operation succeeded.
 */
- (BOOL)update:(NSError **)error;
/*!
 @method destroy:
 @abstract Deletes existing object on remote server.
 @param error Error that has occured while executing the request, if any.
 @result YES if the operation succeeded.
 */
- (BOOL)destroy:(NSError **)error;
/*!
 @method refresh:
 @abstract Pulls latest changes from remote server.
 @param error Error that has occured while executing the request, if any.
 @result YES if the operation succeeded.
 */
- (BOOL)refresh:(NSError **)error;

/*!
 @method query:params:error:
 @abstract Fetches objects from remote server.
 @param scope Named scope to request.
 @param params Named scope parameters.
 @param error Error that has occured while executing the request, if any.
 @result Array of objects.
 */
+ (NSArray *)query:(NSString *)scope params:(NSDictionary *)params error:(NSError **)error;
/*!
 @method query:params:offset:limit:error:
 @abstract Fetches objects from remote server, with pagination.
 @param scope Named scope to request.
 @param params Named scope parameters.
 @param offset Number of objects to skip.
 @param limit Maximum number of objects to fetch.
 @param error Error that has occured while executing the request, if any.
 @result Array of objects.
 */
+ (NSArray *)query:(NSString *)scope params:(NSDictionary *)params offset:(NSUInteger)offset limit:(NSUInteger)limit error:(NSError **)error;
/*!
 @method aggregateQuery:params:error:
 @abstract Executes aggregate query on remote server.
 @param scope Named scope to request.
 @param params Named scope parameters.
 @param error Error that has occured while executing the request, if any.
 @result Result of aggregate query.
 */
+ (NSNumber *)aggregateQuery:(NSString *)scope params:(NSDictionary *)params error:(NSError **)error;

#pragma mark -
#pragma mark CRUD (Async)

/*!
 @methodgroup CRUD Methods (Asynchronuous)
 */

/*!
 @method createAsync:
 @abstract Persists new object on remote server.
 @param callback Callback to be executed when operation completes.
 @discussion Make sure to set the primary key unless it is generated by the server.
 */
- (void)createAsync:(APObjectCallback)callback;
/*!
 @method updateAsync:
 @abstract Updates existing object on remote server.
 @param callback Callback to be executed when operation completes.
 */
- (void)updateAsync:(APObjectCallback)callback;
/*!
 @method destroyAsync:
 @abstract Deletes existing object on remote server.
 @param callback Callback to be executed when operation completes.
 */
- (void)destroyAsync:(APObjectCallback)callback;
/*!
 @method refreshAsync:
 @abstract Pulls latest changes from remote server.
 @param callback Callback to be executed when operation completes.
 */
- (void)refreshAsync:(APObjectCallback)callback;

/*!
 @method query:params:async:
 @abstract Returns cached objects, then fetches fresh data from remote server.
 @param scope Named scope to request.
 @param params Named scope parameters.
 @param callback Callback to be executed when operation completes.
 @result Array of cached objects.
 */
+ (NSArray *)query:(NSString *)scope
            params:(NSDictionary *)params
             async:(APObjectsCallback)callback;
/*!
 @method query:params:offset:limit:async:
 @abstract Returns cached objects, then fetches fresh data from remote server, with pagination.
 @param scope Named scope to request.
 @param params Named scope parameters.
 @param offset Number of objects to skip.
 @param limit Maximum number of objects to fetch.
 @param callback Callback to be executed when operation completes.
 @result Array of cached objects.
 */
+ (NSArray *)query:(NSString *)scope
            params:(NSDictionary *)params
            offset:(NSUInteger)offset
             limit:(NSUInteger)limit
             async:(APObjectsCallback)callback;
/*!
 @method aggregateQuery:params:async:
 @abstract Executes aggregate query on remote server.
 @param scope Named scope to request.
 @param params Named scope parameters.
 @param callback Callback to be executed when operation completes.
 */
+ (void)aggregateQuery:(NSString *)scope
      params:(NSDictionary *)params
       async:(APObjectCallback)callback;

@end
